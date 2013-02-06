require 'json'

module Crashplan
  APP_CODE = 'CPP'

  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    def object_from_response(klass, request_method, path, options = {})
      response = send(request_method.to_sym, path, options)
      klass.from_response(response)
    end

    def objects_from_response(klass, request_method, path, options = {})
      response = send(request_method.to_sym, path, options)['data']
      objects_from_array(klass, response)
    end

    def objects_from_array(klass, array)
      array.map { |element| klass.deserialize_and_initialize(element) }
    end

    def get_token(app_code = APP_CODE)
      object_from_response(Token, :post, "authToken", { appCode: app_code })
    end

    def user(id = "my")
      object_from_response(User, :get, "user/#{id}")
    end

    def org(id = "my")
      object_from_response(Org, :get, "org/#{id}")
    end

    def ping
      response = get 'ping'
      Ping.new(response["data"])
    end

    def delete_token(token)
      delete "authToken/#{token.to_s}"
    end

    def create_org(data = {})
      object_from_response(Org, :post, "org", Org.serialize(data))
    end

    def create_user(data = {})
      object_from_response(User, :post, "user", User.serialize(data))
    end

    def validate_token(token)
      object_from_response(TokenValidation, :get, "authToken/#{token.token_string}")
    end

    def user_roles(id = 'my')
      objects_from_response(UserRole, :get, "userRole/#{id}")
    end

    def use_basic_auth(username, password)
      settings.username = username
      settings.password = password
    end

    def use_token_auth(token)
      settings.token = token.to_s
    end

    def username=(username)
      settings.username = username
    end

    def password=(password)
      settings.password = password
    end

    def token=(token)
      settings.token = token.to_s
    end

    def connection
      @connection = Connection.new(
        host: settings.host,
        port: settings.port,
        scheme: settings.scheme,
        path_prefix: settings.api_root
      )
      if settings.username && settings.password
        @connection.username = settings.username
        @connection.password = settings.password
      end
      if settings.token
        @connection.token = settings.token
      end
      @connection
    end

    def get(path, data = {})
      make_request(:get, path, data)
    end

    def post(path, data = {})
      make_request(:post, path, data)
    end

    def delete(path, data = {})
      make_request(:delete, path, data)
    end

    def make_request(method, *args)
      connection.make_request(method, *args)
    end
  end
end
