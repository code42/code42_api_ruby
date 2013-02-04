require 'faraday'

module Crashplan
  class Connection
    attr_accessor :host, :port, :scheme, :path_prefix, :username, :password, :adapter, :token

    def initialize(options = {})
      self.adapter     = Faraday.new
      self.host        = options[:host]
      self.port        = options[:port]
      self.scheme      = options[:scheme]
      self.path_prefix = options[:path_prefix]
      self.username    = options[:username]
      self.password    = options[:password]
      self.token       = options[:token]

      adapter.host        = host
      adapter.port        = port
      adapter.scheme      = scheme
      adapter.path_prefix = path_prefix
    end

    def has_valid_credentials?
      username && password
    end

    def token=(token)
      @token = token
      adapter.headers['Authorization-Challenge'] = "false"
      adapter.headers['Authorization'] = "TOKEN #{encoded_token}"
      @token
    end

    def encoded_token
      Base64.strict_encode64(token) if token
    end

    def username=(username)
      @username = username
      adapter.basic_auth(username, password) if has_valid_credentials?
    end

    def password=(password)
      @password = password
      adapter.basic_auth(username, password) if has_valid_credentials?
    end

    def get(path)
      response = adapter.get(path)
      response.body
    end

    def post(path, data)
      adapter.headers['Content-Type'] = 'application/json'
      response = adapter.post path, data.to_json
      response.body
    end

    def respond_to?(method_name, include_private = false)
      adapter.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION < "1.9"

    def respond_to_missing?(method_name, include_private = false)
      adapter.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION >= "1.9"

    private

    def method_missing(method_name, *args, &block)
      return super unless adapter.respond_to?(method_name)
      adapter.send(method_name, *args, &block)
    end
  end
end
