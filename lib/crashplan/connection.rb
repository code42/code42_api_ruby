require 'faraday'
require 'faraday_middleware'
require 'logger'
require 'crashplan/error'

module Crashplan
  class Connection
    attr_accessor :host, :port, :scheme, :path_prefix, :username, :password, :adapter, :token

    def initialize(options = {})
      self.host        = options[:host]
      self.port        = options[:port]
      self.scheme      = options[:scheme]
      self.path_prefix = options[:path_prefix]
      self.username    = options[:username]
      self.password    = options[:password]
      self.token       = options[:token] if options[:token]

      adapter.host        = host
      adapter.port        = port
      adapter.scheme      = scheme
      adapter.path_prefix = path_prefix
    end

    def adapter
      if !@adapter
        @adapter = Faraday.new
        @adapter.response :json
      end
      @adapter
    end

    def has_valid_credentials?
      username && password
    end

    def token=(token)
      @token = token
      adapter.headers['Authorization-Challenge'] = "false"
      adapter.headers['Authorization'] = "TOKEN #{token}"
      @token
    end

    def username=(username)
      @username = username
      adapter.basic_auth(username, password) if has_valid_credentials?
    end

    def password=(password)
      @password = password
      adapter.basic_auth(username, password) if has_valid_credentials?
    end

    def make_request(method, *args)
      response = self.send(method, *args)
      check_for_errors(response)
      response.body
    end

    def get(path, data)
      adapter.get(path, data)
    end

    def post(path, data)
      adapter.headers['Content-Type'] = 'application/json'
      adapter.post path, data.to_json
    end

    def delete(path, data)
      adapter.delete(path, data)
    end

    def respond_to?(method_name, include_private = false)
      adapter.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION < "1.9"

    def respond_to_missing?(method_name, include_private = false)
      adapter.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION >= "1.9"

    private

    def check_for_errors(response)
      if response.status == 401
        raise Crashplan::Error::AuthenticationError
      elsif response.status >= 400 && response.status < 600
        if response.body.is_a?(Array)
          messages = response.body.map { |b| b['description'] }.join(', ')
        end
        raise Crashplan::Error, messages
      end
    end

    def method_missing(method_name, *args, &block)
      return super unless adapter.respond_to?(method_name)
      adapter.send(method_name, *args, &block)
    end
  end
end
