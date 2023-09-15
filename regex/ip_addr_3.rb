require 'byebug'
def is_valid_ip_address? ip
  if ip.count(".") == 3
    ip.split(".").all? {|num| num[/^\d{1,3}$/] && num.to_i < 256 }
  end
end

p is_valid_ip_address?("999.16.0.0") ? "Valid" : "Invalid"
p is_valid_ip_address?("172.16.0.0") ? "Valid" : "Invalid"
p is_valid_ip_address?("172.31.255.255") ? "Valid" : "Invalid"
p is_valid_ip_address?("172.31.255.256") ? "Valid" : "Invalid"
p is_valid_ip_address?("hhhj.gghh.255.256") ? "Valid" : "Invalid"