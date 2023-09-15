#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative 'service_name'

class TestServiceName < Minitest::Test
  def test_service_name
    service = Servicename.new
    assert service.service_name("zendesk_system_user_mac_test_app_upcoming") == "test_app"
  end
end

