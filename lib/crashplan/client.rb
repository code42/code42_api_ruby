require 'json'

module Crashplan
  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    def get_token(data = {})
      object_from_response(Token, :post, "authToken", data)
    end

    def user(id = "my")
      object_from_response(User, :get, "user/#{id}")
    end

    def org(id = "my")
      object_from_response(Org, :get, "org/#{id}")
    end

    def search_orgs(query)
      orgs(q: query)
    end

    def orgs(data = {})
      options = data.merge(key: 'orgs')
      objects_from_response(Org, :get, 'org', options)
    end

    def users(data = {})
      options = data.merge(key: 'users')
      objects_from_response(User, :get, 'user', options)
    end

    def ping
      response = get 'ping'
      Ping.new(response["data"])
    end

    def delete_token(token = nil)
      token = token || settings.token
      delete "authToken/#{token.to_s}"
    end

    def create_org(data = {})
      object_from_response(Org, :post, "org", data)
    end

    def create_user(data = {})
      object_from_response(User, :post, "user", data)
    end

    def create_user_role(data = {})
      object_from_response(UserRole, :post, 'UserRole', data)
    end

    def validate_token(token)
      object_from_response(TokenValidation, :get, "authToken/#{token.to_s}")
    end

    def user_roles(id = 'my')
      collection_from_response(UserRoleCollection, UserRole, :get, "userRole/#{id}")
    end

    def use_basic_auth(username, password)
      settings.token = nil
      settings.username = username
      settings.password = password
    end

    def use_token_auth(token)
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

    private

    def object_from_response(klass, request_method, path, options = {})
      options = klass.serialize(options)
      response = send(request_method.to_sym, path, options)
      klass.from_response(response, self)
    end

    def objects_from_response(klass, request_method, path, options = {})
      key = options.delete(:key)
      response = send(request_method.to_sym, path, options)['data']
      response = response[key] if key
      objects_from_array(klass, response)
    end

    def collection_from_response(collection_klass, object_klass, request_method, path, options = {})
      collection_klass.new objects_from_response(object_klass, request_method, path, options)
    end

    def objects_from_array(klass, array)
      array.map { |element| klass.deserialize_and_initialize(element, self) }
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
