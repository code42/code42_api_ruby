module Crashplan
  class Client
    attr_accessor :host, :port
    def user
      check_settings
      "my user"
    end
    def org
      check_settings
      "my org"
    end
    def check_settings
      raise "Host is not set" if host.nil?
      raise "Port is not set" if port.nil?
    end
  end
end
