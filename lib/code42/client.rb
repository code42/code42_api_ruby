# Copyright (c) 2016 Code42, Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
require 'faraday'
require 'forwardable'
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
    include Code42::API::ServerEnv
    include Code42::API::PasswordReset
    include Code42::API::StorePoint
    include Code42::API::Diagnostic
    include Code42::API::ServerConnectionString

    attr_reader :settings

    extend Forwardable

    instance_delegate make_request: :connection

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
      # Spaces need to be URI encoded to +.
      make_request(:get, path.gsub(/ +/, '+'), data, &block)
    end

    def post(path, data = {}, &block)
      make_request(:post, path.gsub(/ +/, '+'), data, &block)
    end

    def put(path, data = {}, &block)
      make_request(:put, path.gsub(/ +/, '+'), data, &block)
    end

    def delete(path, data = {}, &block)
      make_request(:delete, path.gsub(/ +/, '+'), data, &block)
    end
  end
end
