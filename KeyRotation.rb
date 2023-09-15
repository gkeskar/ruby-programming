require 'optparse'
require 'json'
require 'colorize'

options = { path: 'secret/legacy/system_users/oauth' } #default options
opt_parser = OptionParser.new do |opts|
  opts.on('-u', '--username=USERNAME', 'LDAP username') { |u| options[:username] = u }
  opts.on('-c', '--command=COMMAND', %w[create copy rotate], 'Operation on key: create, copy, rotate') { |c| options[:command] = c }
  opts.on('-k', '--key=KEY', 'KEY to rotate') { |k| options[:key] = k }
  opts.on('-d', '--dry_run', 'Perform a dry run; no destructive operations will occur.') { |d| options[:dry_run] = d }
  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end

opt_parser.parse!
p options


class Key_rotation
  VAULT_STG_URL = 'https://secret.zdsystest.com:8200'

  attr_accessor :options

  def initialize(options)
    @options = options
  end

  def vault_login?(username)
    username = @options[:username]
    puts `export VAULT_ADDR=#{VAULT_STG_URL}; vault login -method=ldap -path=sqid username=#{username}`
    true if $?.exitstatus.zero?
  end

  def service_name(key)
    secret_name = key.split("/").last
    if secret_name.match(/^zendesk_system_user_mac_/)
      service_name = key.split("/").last.gsub("zendesk_system_user_mac_", "")
    else
      service_name = secret_name
    end
  end

  def key_exists?(key)
    key_data = `vault kv get -format=json #{key} | jq '.data.data'`
    if key_data.empty?
      false
    else
      true
    end
  end

  def put_key(key, create_mode, dry_run)
    cas = create_mode ? "-cas 0" : "" #check-and-set-operation flag
    service = service_name(key)
    value = `openssl rand -hex 32`
    data_hash = {
        "comment"=>"MAC key updated by key_rotation script for System User:#{service}",
        "creator_id"=>1,
        "deprecated_at"=>nil,
        "updater_id"=>1,
        "vault"=> value.chomp,
        "visible"=>false
    }
    key_name = key.split("/").last
    key_data_file = File.new("key.json", "w")
    File.write(key_data_file, JSON.dump(data_hash))

    command = "vault kv put #{cas} #{key} @key.json"
    c = "vault kv put #{cas} #{key} @key.json"

    if dry_run
      # check if key exists to raise exception as we are not executing command in dry run
      if cas == "-cas 0"
        # new key : cas is checked, if key exits then raise exception otherwise print command
        if key_exists?(key)
          raise "Key '#{key}' already exists".red
        else
          puts "'#{key}' will be created by executing command:\n [ #{c} ]".green
        end
      elsif cas.empty?
        # updating existing key: cas is not set
        puts "'#{key}' will be updated by executing command:\n [ #{c} ]".green
      end
    else
      `#{command}`
      # check if key is created successfully by reading the key, since vault kv put always exit 0
      if key_exists?(key)
        puts "Successfully created '#{key}'".green unless dry_run
      end
    end
    key_data_file.close
    File.delete(key_data_file)
    # check if key is created successfully by reading the key, since vault kv put always exit 0
  end

  def main()
    username = options[:username]
    path = options[:path]
    operation = options[:command]
    secret = options[:key]
    key = path.to_s + '/' + secret.to_s
    dry_run = options[:dry_run]

    if vault_login?(username)
      puts "login successful"
      case operation
      when 'create'
        put_key(key, true, dry_run)
      else
        raise 'Invalid Operation argument'
      end
    else
      raise 'Error in vault login'
    end
  end
end

key_rotation = Key_rotation.new(options)
key_rotation.main()