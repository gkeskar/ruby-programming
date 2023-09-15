#!/usr/bin/env ruby
#
# To build key database
require 'sqlite3'
require 'colorize'
#puts "It's okay" if defined?(SQLite3::Database)

$db = SQLite3::Database.new("dbfile")
$db.results_as_hash = true

def create_table
  puts "Creating keys table".green
  $db.execute %q{
    CREATE TABLE keys (
    id integer primary key,
    name text(50),
    app text(6),
    team text(6),
    location text(50),
    product text(50),
    tier text)
  }
end

def add_key
  puts "Enter name:".blue
  name = gets.chomp
  puts "Enter application:".blue
  app = gets.chomp
  puts "Enter team:".blue
  team = gets.chomp
  puts "Enter location:".blue
  location = gets.chomp
  puts "Enter product:".blue
  product = gets.chomp
  puts "Enter tier:".blue
  tier = gets.chomp
  $db.execute("INSERT INTO keys (name, app, team, location, product, tier) VALUES (?, ?, ?, ?, ?, ?)",
  name, app, team, location, product, tier)
end

def update_key
  puts "Enter name:" .blue
  name = gets.chomp
  puts "name: #{name}"
  puts "Enter field to update:(name,app,team,location,product,tier" .blue
  field = gets.chomp
  puts "Enter value" .blue
  value = gets.chomp
  $db.execute("UPDATE keys SET #{field}=\"#{value}\" where name = \"#{name}\"")
end

def delete_key
  puts "Enter name:" .blue
  name = gets.chomp
  puts "name: #{name}"
  $db.execute("DELETE FROM keys where name = \"#{name}\" ")
end

def multiple_values?(key,field)
  true if key[ field ].match(/.*,.*/)
end

def multiple_values(key,field)
  fields = key[field].split(',')
end

def find_key
  puts "Enter name or ID of key to find:".blue
  id = gets.chomp

  key = $db.execute("SELECT * FROM keys WHERE name = ? OR id = ?", id, id.to_i).first

  unless key
    puts "No result found".red
    return
  end

  def multiple_values?(key,field)
    true if key[ field ].match(/.*,.*/)
  end

  def multiple_values(key,field)
    fields = key[field].split(',')
  end

  if multiple_values?(key, 'team')
    team = multiple_values(key, 'team')
  else
    team = key['team']
  end

  if multiple_values?(key, 'location')
    location = multiple_values(key, 'location')
  else
    location = key['location']
  end

  if multiple_values?(key, 'product')
    product = multiple_values(key, 'product')
  else
    product = key['product']
  end

  puts "Here you go!!!: ".green
  puts %Q{Name: #{key['name']}
  Application: #{key['app']}
  Team: #{team}
  Location: #{location}
  Product: #{product}
  Tier: #{key['tier']}}.green
end

def find_key_on_location
  puts "Enter location:".blue
  location = gets.chomp

  keys = $db.execute("SELECT * FROM keys WHERE location = \"#{location}\" OR location = \"Multiple\"")

  unless keys
    puts "No result found".red
    return
  end
  puts "Here you go!!!: ".green

  keys.each do |key|
    puts key['name']
  end
  puts "#{keys.length} Keys"
end

def find_key_on_product
  puts "Enter product:".blue
  product = gets.chomp

  keys = $db.execute("SELECT * FROM keys WHERE product = \"#{product}\"")

  unless keys
    puts "No result found".red
    return
  end
  puts "Here you go!!!: ".green

  keys.each do |key|
    puts key['name']
  end
  puts "#{keys.length} Keys"
end

def find_key_on_product_location
  puts "Enter product:".blue
  product = gets.chomp

  puts "Enter location:".blue
  location = gets.chomp

  keys = $db.execute("SELECT * FROM keys WHERE product = \"#{product}\" AND location =  \"#{location}\" OR location = \"Multiple\"")

  unless keys
    puts "No result found".red
    return
  end
  puts "Here you go!!!: ".green

  keys.each do |key|
    puts key['name']
  end
  puts "#{keys.length} Keys"
end

def find_key_with_location_no_product
  puts "Enter product:".blue
  product = gets.chomp

  puts "Enter location:".blue
  location = gets.chomp

  keys = $db.execute("SELECT * FROM keys WHERE product != \"#{product}\" AND location =  \"#{location}\" OR location = \"Multiple\"")

  unless keys
    puts "No result found".red
    return
  end
  puts "Here you go!!!: ".green

  keys.each do |key|
    puts key['name']
  end
  puts "#{keys.length} Keys"
end

def find_key_with_location_no_product_tier2_tier3_tier4
  puts "Enter product:".blue
  product = gets.chomp

  puts "Enter location:".blue
  location = gets.chomp

  keys = $db.execute("SELECT * FROM keys WHERE product != \"#{product}\" AND (location =  \"#{location}\" OR location = \"Multiple\") AND (tier = \"Tier2\" OR tier = \"Tier3\" OR tier = \"Tier4\" OR tier = \"N/A\")")

  unless keys
    puts "No result found".red
    return
  end
  puts "Here you go!!!: ".green

  keys.each do |key|
    puts key['name']
  end
  puts "#{keys.length} Keys"
end

def disconnect_and_quit
  $db.close
  puts "Bye!".green
  exit
end

loop do
  puts %q{Please select an option:

    1. Create keys table
    2. Add a key
    3. Look for a key
    4. Enter location
    5. Enter Product
    6. Enter location and product
    7. Enter location and NO product
    8. Enter location and NO product(tier2, tier3 and tier4)
    9. Update key
    10. Delete key
    11. Quit}.blue

  case gets.chomp
  when '1'
    create_table
  when '2'
    add_key
  when '3'
    find_key
  when '4'
    find_key_on_location
  when '5'
    find_key_on_product
  when '6'
    find_key_on_product_location
  when '7'
    find_key_with_location_no_product
  when '8'
    find_key_with_location_no_product_tier2_tier3_tier4
  when '9'
    update_key
  when '10'
    delete_key
  when '11'
    disconnect_and_quit
  end
end