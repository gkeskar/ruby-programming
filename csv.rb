#!/usr/bin/env ruby

require 'csv'
require 'optparse'

options = {}

opt_parser = OptionParser.new do |opts|
  opts.on('-f', '--file=FILE', 'Key file') { |f| options[:file] = f }
  opts.separator 'Options:'
  opts.on('-l', '--location[=location]', 'Team location') { |l| options[:location] = l }
  opts.on('-n', '--no_product[=product]', 'Product') { |n| options[:no_product] = n }
  opts.on('-p', '--with_product[=product]', 'Product') { |p| options[:with_product] = p }

  opts.separator 'Help:'
  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end

opt_parser.parse!
p "Options:", options

selection =""
if options[:location] && options[:with_product] == nil && options[:no_product] == nil
  selection = "only_location"
end
if  options[:with_product] && options[:location] == nil && options[:no_product] == nil
  selection = "only_product"
end
if options[:no_product] && options[:location] == nil && options[:with_product] == nil
  selection = "no_product"
end
if options[:location] &&  options[:no_product] && options[:with_product] == nil
  selection = "location_no_product"
end
if options[:location] &&  options[:with_product] && options[:no_product] == nil
  selection = "location_with_product"
end


def read_keys(filename)
  all_keys = []
  file = filename
  CSV.open(file).each do |key|
    all_keys.push(key)
  end
  all_keys
end

def keys_with_product(keys, product)
  puts "came here"
  ks = []
  keys.each do |key|
    ks.push(key) if ( key[4] ==  product)
  end
  ks
end

def keys_without_product(keys, product)
  puts "came here"
  ks = []
  keys.each do |key|
    ks.push(key) if ( key[4] !=  product)
  end
  ks
end

def keys_with_location(keys,location)
  puts "came here"
  ks = []
  keys.each do |key|
    ks.push(key) if ( key[3] ==  location || key[3] == "Multiple")
  end
  ks
end
filename = options[:file]
case selection
when "only_product"
  puts "product option"
  keys = read_keys(filename)
  keys_with_product = keys_with_product(keys, options[:with_product])
  keys_with_product.each {|k| puts "#{k}"}
  puts "#{keys_with_product.count} keys, out of #{keys.count} total keys"
  exit
when "no_product"
  puts "no product option"
  keys = read_keys(filename)
  keys_without_product = keys_without_product(keys, options[:no_product])
  keys_without_product.each {|k| puts "#{k}"}
  puts "#{keys_without_product.count} keys, out of #{keys.count} total keys"
  exit
when "only_location"
  puts "location option"
  keys = read_keys(filename)
  keys_with_location = keys_with_location(keys, options[:location])
  keys_with_location.each {|k| puts "#{k}"}
  puts "#{keys_with_location.count} keys, out of #{keys.count} total keys"
  exit
when "location_no_product"
  puts "location and no product options"
  keys = read_keys(filename)
  location_specific_keys = keys_with_location(keys, options[:location])
  location_and_product_specific_keys = keys_without_product(location_specific_keys, options[:no_product])
  location_and_product_specific_keys.each {|k| puts "#{k}"}
  puts "#{location_and_product_specific_keys.count} keys, out of #{keys.count} total keys"
  exit
when "location_with_product"
  puts "location and with product options"
  keys = read_keys(filename)
  location_specific_keys = keys_with_location(keys, options[:location])
  location_and_product_specific_keys = keys_with_product(location_specific_keys, options[:with_product])
  location_and_product_specific_keys.each {|k| puts "#{k}"}
  puts "#{location_and_product_specific_keys.count} keys, out of #{keys.count} total keys"
  exit
else
  raise 'Invalid Operation argument'
end

