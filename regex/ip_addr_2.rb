require 'byebug'
def is_valid_ip_address? str
  str.count('.')==3 && str.split('.').all? do |s|
    # byebug
    s[/^\d{1,3}$/] && s.to_i < 256
  end
end


p is_valid_ip_address?("999.16.0.0") ? "Valid" : "Invalid"
p is_valid_ip_address?("172.16.0.0") ? "Valid" : "Invalid"
p is_valid_ip_address?("172.31.255.255") ? "Valid" : "Invalid"
p is_valid_ip_address?("172.31.255.256") ? "Valid" : "Invalid"