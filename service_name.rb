#!/usr/bin/env ruby
class Servicename


  def service_name(key)
    secret_name = key.split("/").last
    if secret_name.match(/_deprecated$|_upcoming$|^zendesk_system_user_mac_/)
      if secret_name.match(/(^zendesk_system_user_mac_)(.*)(_upcoming$|_deprecated$)/)
        service_name = $2
      elsif secret_name.match(/(.*)(_upcoming$|_deprecated$)/)
        service_name = $1
      elsif secret_name.match(/(^zendesk_system_user_mac_)(.*)/)
        service_name = $2
      end
    else
      service_name = secret_name
    end
  end
end

service = Servicename.new()
puts service.service_name("zendesk_system_user_mac_test_app_upcoming")
service = Servicename.new()
puts service.service_name("zendesk_system_user_mac_test")
service = Servicename.new()
puts service.service_name("zendesk_system_user_test")