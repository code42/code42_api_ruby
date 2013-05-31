require 'json'
Dir[File.dirname(__FILE__) + '/api/*.rb'].each { |file| require file }

module Code42
  class Client
    include Code42::API::User
    include Code42::API::Role
    include Code42::API::Org
    include Code42::API::Computer
    include Code42::API::Token

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
    # @param token [Code42::Token, String] The token to authenticate with
    def use_token_auth(token)
      settings.token = token.to_s
    end

    def diagnostic
      object_from_response(Diagnostic, :get, 'diagnostic')
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
      options = klass.serialize(options)
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
