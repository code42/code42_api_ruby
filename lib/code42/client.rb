require 'json'
Dir[File.dirname(__FILE__) + '/api/*.rb'].each { |file| require file }

module Code42
  class Client
    include Code42::API::User
    include Code42::API::Role
    include Code42::API::Org
    include Code42::API::Computer
    include Code42::API::Token
    include Code42::API::ProductLicense
    include Code42::API::ServerSettings
    include Code42::API::Destination
    include Code42::API::Server
    include Code42::API::PasswordReset
    include Code42::API::StorePoint

    attr_reader :settings

    extend Forwardable

    delegate make_request: :connection

    def initialize(options = {})
      self.settings = options
    end

    def last_response; connection.last_response; end

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
    # @param token [Code42::Token, String] The token to authenticate with
    def use_token_auth(token)
      settings.token = token.to_s
    end

    def diagnostic
      object_from_response(Diagnostic, :get, 'diagnostic')
    end

    def org_share_destinations(id)
      get("orgShareDestinations/#{id}")['data']
    end

    def server_connection_string(id)
      object_from_response(Code42::ServerConnectionString, :get, "serverConnectionString/#{id}")
    end

    # Block a computer from backing up
    # @return [Code42::Computer] The blocked computer
    # @params id [Integer, String] The computer ID you want to block
    def block_computer(id)
      put("computerblock/#{id}")
    end

    def unblock_computer(id)
      delete("computerblock/#{id}")
    end

    def deactivate_org(id)
      put("OrgDeactivation/#{id}")
    end

    def connection
      @connection ||= begin
                        connection = Connection.new
                        settings.debug && connection.use(Faraday::Response::Logger)
                        connection
                      end
      @connection.host         = settings.host
      @connection.port         = settings.port
      @connection.scheme       = settings.scheme
      @connection.path_prefix  = settings.api_root
      @connection.verify_https = settings.verify_https
      if settings.username && settings.password
        @connection.username = settings.username
        @connection.password = settings.password
      end
      if settings.token
        @connection.token = settings.token
      end
      if settings.mlk
        @connection.mlk = settings.mlk
      end
      @connection
    end

    private

    def object_from_response(klass, request_method, path, options = {})
      klass = fetch_class(klass)
      options = klass.serialize(options)
      response = send(request_method.to_sym, path, options)
      return nil unless response_has_data?(response)
      klass.from_response(response['data'], self)
    end

    def objects_from_response(klass, request_method, path, options = {})
      key = options.delete(:key)
      klass = fetch_class(klass)
      options = klass.serialize(options)
      response = send(request_method.to_sym, path, options)
      return nil unless response_has_data?(response)
      response = response['data']
      response = response[key] if !response.empty? && key
      objects_from_array(klass, response)
    end

    def fetch_class(klass)
      klass.is_a?(Module) ? klass : Code42.const_get(klass)
    end

    def response_has_data?(response)
      response && response['data']
    end

    def collection_from_response(collection_klass, object_klass, request_method, path, options = {})
      collection_klass.new objects_from_response(object_klass, request_method, path, options)
    end

    def objects_from_array(klass, array)
      array.map { |element| klass.deserialize_and_initialize(element, self) }
    end

    def get(path, data = {}, &block)
      make_request(:get, path, data, &block)
    end

    def post(path, data = {}, &block)
      make_request(:post, path, data, &block)
    end

    def put(path, data = {}, &block)
      make_request(:put, path, data, &block)
    end

    def delete(path, data = {}, &block)
      make_request(:delete, path, data, &block)
    end
  end
end
