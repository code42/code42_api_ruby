require 'json'

module Crashplan
  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    def user
      check_settings
      response = get 'user/my'
    end

    def org
      check_settings
      response = get 'org/my'
      Org.new(response["data"])
    end

    def connection
      Connection.new(
        host: settings.host,
        port: settings.port,
        scheme: settings.scheme,
        path_prefix: settings.api_root,
        username: settings.username,
        password: settings.password
      )
    end

    def get(path)
      if path =~ /user/
        'my user'
      else
        response = connection.get(path)
        response ? JSON.parse(response) : {}
      end
    end

    private

    def check_settings
      raise "Host is not set" if settings.host.nil?
      raise "Port is not set" if settings.port.nil?
    end
  end
end
