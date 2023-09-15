#!/usr/bin/env ruby

s ="zendesk_system_user_mac_audit_log_deprecated"

puts s

# s.match(/(^zendesk_system_user_mac_)(\w+)(_future$)/) do
# puts "came inside"
# puts #{$1}

# end

puts "a1".gsub(/(\w)(\d)/, '\2\1')
puts s.gsub(/(^zendesk_system_user_mac_)(\w+)(_future|_deprecated$)/, '\2')