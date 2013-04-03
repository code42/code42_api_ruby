require 'json'

module Crashplan
  class Client
    attr_accessor :settings

    def initialize(options = {})
      self.settings = options
    end

    def settings=(options)
      @settings = Settings.new(options)
    end

    # Pings the server
    # @return [Boolean] A boolean result (this should always return true)
    def ping
      get('ping')['data']['success']
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

    ### Authentication With Tokens :post, :get, :delete ###

    # Gets a token for the currently authorized user
    def get_token
      object_from_response(Token, :post, "authToken")
    end

    # Returns LoginToken and ServerUrl
    # @return [CrashPlan::Token] Token to pass to ServerUrl's AuthToken resource
    def get_login_token
      object_from_response(Token, :post, "loginToken")
    end

    # Validates an authorization token
    # @return [Crashplan::TokenValidation]
    # @param token [Crashplan::Token, String] The token to validate
    def validate_token(token)
      object_from_response(TokenValidation, :get, "authToken/#{token.to_s}")
    end

    # Manually expires a token
    # @param token [Crashplan::Token, String] A token to expire (leave blank to expire currently used token)
    def delete_token(token = nil)
      token = token || settings.token
      delete "authToken/#{token.to_s}"
    end

    ### Users :post, :get ###

    # Creates a user
    # @return [Crashplan::User] The created user
    # @param attrs [Hash] A hash of attributes to assign to created user
    # @example
    #   client.create_user(:username => 'testuser', password: 'letmein', email: 'test@example.com', org_id: 3)
    def create_user(attrs = {})
      object_from_response(User, :post, "user", attrs)
    end

    # Returns information for a given user
    # @return [Crashplan::User] The requested user
    # @param id_or_username [String, Integer] A crashplan user ID or username
    def user(id_or_username = "my", params = {})
      if id_or_username.is_a?(Fixnum) || id_or_username == 'my'
        find_user_by_id id_or_username, params
      else
        find_user_by_username id_or_username, params
      end
    end

    # Returns a user for a given id
    def find_user_by_id(id = 'my', params = {})
      object_from_response(User, :get, "user/#{id}", params = {})
    end

    # Returns a user for a given username
    def find_user_by_username(username, params = {})
      params.merge!(username: username)
      users(params).first
    end

    # Returns a user for a given channel id
    # @return [Crashplan::User] The requested user
    # @param channel_id [String, Integer] A crashplan User
    def find_user_by_channel_id(channel_id = 1)
      object_from_response(User, :get, "userChannel?channelCustomerId=#{channel_id}")
    end

    # Returns a list of up to 100 users
    # @return [Array] An array of matching users
    # @param params [Hash] A hash of parameters to match results against
    def users(params = {})
      params.merge!(key: 'users')
      objects_from_response(User, :get, 'user', params)
    end

    # Check if user exists with given username.
    def user_exists?(username)
      users(username: username).present?
    end

    ### Roles :post, :get ###

    # Assigns a role to a user
    # @return [Crashplan::Role] The assigned role
    # @param attrs [Hash] A hash of attributes for assigning a user role
    # @example
    #   client.assign_role(:user_id => 2, :role_name => 'Admin')
    def assign_role(attrs = {})
      object_from_response(Role, :post, 'UserRole', attrs)
    end

    # Returns a list of roles for a given user
    # @return [Crashplan::RoleCollection] A collection of matching roles
    # @param id [String, Integer] The id of the user to return roles for
    def user_roles(id = 'my')
      collection_from_response(RoleCollection, Role, :get, "userRole/#{id}")
    end

    ### Orgs :post, :get, :put, :delete ###

    # Creates blue org as well as user for the org
    # @return [Crashplan::Org] The created org
    # @param attrs [Hash] A hash of attributes to assign to created org
    # @example
    #   client.create_org(:company => "test", :email => "test@test.com", :firstname => "test", :lastname => "test")
    def create_pro_org(attrs = {})
      object_from_response(Org, :post, "proOrgChannel", attrs)
    end

    # Creates an org
    # @return [Crashplan::Org] The created org
    # @param attrs [Hash] A hash of attributes to assign to created org
    # @example
    #   client.create_org(:name => 'Acme Org', :parent_id => 2)
    def create_org(attrs = {})
      object_from_response(Org, :post, "org", attrs)
    end

    # Returns information for a given org
    # @return [Crashplan::Org] The requested org
    # @param id [String, Integer] A crashplan user ID
    def org(id = "my")
      object_from_response(Org, :get, "org/#{id}")
    end

    # Returns an org for a given name
    # @return [Crashplan::Org] The requested org
    # @param name [String] A Crashplan org name
    # FIXME: This needs to change when the API implements a better way.
    def find_org_by_name(name)
      search_orgs(name).select { |o| o.name == name }.first
    end

    # Searches orgs for a query string
    # @return [Array] An array of matching orgs
    # @param query [String] A string to search for
    def search_orgs(query)
      orgs(q: query)
    end

    # Creates a user
    # @return [Crashplan::User] The created user
    # @param attrs [Hash] A hash of attributes to assign to created user
    # @example
    #   client.create_user(:username => 'testuser', :password => 'letmein', :email => 'test@example.com', :org_id => 3)
    def create_user(attrs = {})
      object_from_response(User, :post, "user", attrs)
    end

    # Returns a list of up to 100 orgs
    # @return [Array] An array of matching orgs
    # @param params [Hash] A hash of parameters to match results against
    def orgs(params = {})
      params.merge!(key: 'orgs')
      objects_from_response(Org, :get, 'org', params)
    end

    def update_org(id = 'my', attrs = {})
      object_from_response(Org, :put, "org/#{id}", attrs)
    end

    ### Computers :get, :put  ###

    # Returns one computer or http status 404
    # @return [Crashplan::Computer] The requested computer
    # @param id [String, Integer] A computer ID
    def computer(id)
      object_from_response(Computer, :get, "computer/#{id}")
    end

    # Returns a list of computers
    # @return [Array] The list of computers
    # @param params [Hash] A hash of valid search parameters for computers
    def computers(params = {})
      params.merge!(key: 'computers')
      objects_from_response(Computer, :get, 'computer', params)
    end

    # Block a computer from backing up
    # @return [Crashplan::Computer] The blocked computer
    # @params id [Integer, String] The computer ID you want to block
    def block_computer(id)
      put("computerblock/#{id}")
    end

    def unblock_computer(id)
      delete("computerblock/#{id}")
    end

    def connection
      @connection = Connection.new(
        host: settings.host,
        port: settings.port,
        scheme: settings.scheme,
        path_prefix: settings.api_root,
        verify_https: settings.verify_https,
      )
      if settings.debug
        @connection.use Faraday::Response::Logger
      end
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
      return nil unless response_has_data?(response['data'])
      klass.from_response(response['data'], self)
    end

    def objects_from_response(klass, request_method, path, options = {})
      key = options.delete(:key)
      response = send(request_method.to_sym, path, options)
      return nil unless response_has_data?(response)
      response = response['data']
      response = response[key] if key
      objects_from_array(klass, response)
    end

    def response_has_data?(response)
      !response.nil?
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

    def put(path, data = {})
      make_request(:put, path, data)
    end

    def delete(path, data = {})
      make_request(:delete, path, data)
    end

    def make_request(method, *args)
      connection.make_request(method, *args)
    end
  end
end
