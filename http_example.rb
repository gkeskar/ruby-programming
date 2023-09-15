#!/usr/bin/env ruby
#
require 'net/http'
require 'byebug'
require 'json'
require 'uri'

uri = URI('https://samson.zende.sk/secrets/new')
request = Net::HTTP::Post.new(uri)
request['Authorization'] = "Bearer #{ENV['SAMSON_TOKEN']}"
request.body = {
    "secret[environment_permalink]" => "staging",
     "secret[project_permalink]" => "global",
    "secret[deploy_group_permalink]" => "global",
    "secret[key]" => "test",
    "secret[comment]" => "test",
    "secret[value]" => "test1234"
}.to_json

http = Net::HTTP.new(uri.hostname, uri.port)
http.use_ssl = true
response = http.request(request)
puts response.code
puts response.message

unless ( ENV.key?('SAMSON_TOKEN'))
  puts "OOPS!  Here's how to run this, dummy: `SAMSON_TOKEN="" http_example.rb`"
  exit 1
end







