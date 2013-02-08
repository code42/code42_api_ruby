require 'json'

module Crashplan
  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    # Gets a token for the currently authorized user
    def get_token
      object_from_response(Token, :post, "authToken")
    end

    # Returns information for a given user
    # @return [Crashplan::User] The requested user
    # @param id [String, Integer] A crashplan user ID
    def user(id = "my")
      object_from_response(User, :get, "user/#{id}")
    end

    # Returns information for a given org
    # @return [Crashplan::Org] The requested org
    # @param id [String, Integer] A crashplan user ID
    def org(id = "my")
      object_from_response(Org, :get, "org/#{id}")
    end

    # Searches orgs for a query string
    # @return [Array] An array of matching orgs
    # @param query [String] A string to search for
    def search_orgs(query)
      orgs(q: query)
    end

    # Returns a list of up to 100 orgs
    # @return [Array] An array of matching orgs
    # @param params [Hash] A hash of parameters to match results against
    def orgs(params = {})
      params.merge!(key: 'orgs')
      objects_from_response(Org, :get, 'org', params)
    end

    # Returns a list of up to 100 users
    # @return [Array] An array of matching users
    # @param params [Hash] A hash of parameters to match results against
    def users(params = {})
      params.merge(key: 'users')
      objects_from_response(User, :get, 'user', params)
    end

    # Pings the server
    # @return [Boolean] A boolean result (this should always return true)
    def ping
      get('ping')['data']['success']
    end

    # Manually expires a token
    # @param token [Crashplan::Token, String] A token to expire (leave blank to expire currently used token)
    def delete_token(token = nil)
      token = token || settings.token
      delete "authToken/#{token.to_s}"
    end

    # Creates an org
    # @return [Crashplan::Org] The created org
    # @param attrs [Hash] A hash of attributes to assign to created org
    # @example
    #   client.create_org(:name => 'Acme Org', :parent_id => 2)
    def create_org(attrs = {})
      object_from_response(Org, :post, "org", attrs)
    end

    # Creates a user
    # @return [Crashplan::User] The created user
    # @param attrs [Hash] A hash of attributes to assign to created user
    # @example
    #   client.create_user(:username => 'testuser', password: 'letmein', email: 'test@example.com', org_id: 3)
    def create_user(attrs = {})
      object_from_response(User, :post, "user", attrs)
    end

    # Assigns a role to a user
    # @return [Crashplan::UserRole] The assigned role
    # @param attrs [Hash] A hash of attributes for assigning a user role
    # @example
    #   client.assign_user_role(:user_id => 2, :role_name => 'Admin')
    def assign_user_role(attrs = {})
      object_from_response(UserRole, :post, 'UserRole', attrs)
    end

    # Validates an authorization token
    # @return [Crashplan::TokenValidation]
    # @param token [Crashplan::Token, String] The token to validate
    def validate_token(token)
      object_from_response(TokenValidation, :get, "authToken/#{token.to_s}")
    end

    # Returns a list of roles for a given user
    # @return [Crashplan::UserRoleCollection] A collection of matching user roles
    # @param id [String, Integer] The id of the user to return roles for
    def user_roles(id = 'my')
      collection_from_response(UserRoleCollection, UserRole, :get, "userRole/#{id}")
    end

    # Use basic authentication for future requests
    # @param username [String] The username to authenticate with
    # @param password [String] The password to authenticate with
    def use_basic_auth(username, password)
      settings.token = nil
      settings.username = username
      settings.password = password
    end

    # Use token authentication for future requests
    # @param token [Crashplan::Token, String] The token to authenticate with
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
