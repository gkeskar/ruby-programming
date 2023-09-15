#!/usr/bin/env ruby

# froze_string_literal: true

require 'json'
require 'net/http'

def here(relpath)
  File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), relpath)
end

def request(path)
  uri = URI("https://samson.zende.sk#{path}")
  response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    request = Net::HTTP::Get.new uri
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{ENV['SAMSON_TOKEN']}"
    http.request request
  end
  JSON.parse(response.body)
end

def fetch_environment_variables_groups
  request('/environment_variable_groups.json')['environment_variable_groups']
end

def fetch_group_preview(id)
  groups = request("/environment_variable_groups/preview.json?group_id=#{id}")['groups']
  groups = groups.map { |g| { name: g[0].slice(1), data: g[1] } }
  groups.reject! { |g| g[:data].empty? }
  groups.each do |group|
    group[:data].each do |_k, val|
      val.slice!(' X') if val.start_with? 'secret://'
    end
  end
  Hash[groups.map { |o| [o[:name], o[:data]] }]
end

unless (ARGV.length == 1 && ENV.key?('SAMSON_TOKEN'))
  puts "OOPS!  Here's how to run this, dummy: `SAMSON_TOKEN="" export.rb <ENVIRONMENT_VARIABLE_GROUP_NAME>`"
  exit 1
end

name = ARGV.first
puts "searching for #{name} environment variable group..."

group = fetch_environment_variables_groups.find { |g| g['name'] == name }

if group.nil?
  puts "Ah shit, no group named #{name}..."
  exit 1
end

puts "fetching preview for group with id #{group['id']}"
content = fetch_group_preview(group['id'])

target = here("templates/shared_env_groups/#{name.downcase}.json")
puts "writing to #{target}"
File.open(target, 'w') do |f|
  f.write(JSON.pretty_generate(content))
end

puts "https://samson.zende.sk/environment_variable_groups/#{group['id']}"