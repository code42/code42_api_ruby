require 'json'

module Crashplan
  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    def user(id = "my")
      response = get "user/#{id}"
      User.from_response(response)
    end

    def org(id = "my")
      response = get "org/#{id}"
      Org.from_response(response)
    end

    def ping
      check_settings
      response = get 'ping'
      Ping.new(response["data"])
    end

    def create_org(data = {})
    end

    def create_user(data = {})
      response = post "user", data
      User.from_response(response)
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
      make_request(:get, path)
    end

    def post(path, data = {})
      make_request(:post, path, data)
    end

    def make_request(method, *args)
      response = connection.send(method, *args)
      response_body(response)
    end

    private

    def response_body(response)
      response ? JSON.parse(response) : {}
    end

    def check_settings
      raise "Host is not set" if settings.host.nil?
      raise "Port is not set" if settings.port.nil?
    end
  end
end
