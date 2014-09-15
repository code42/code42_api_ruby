require 'bundler/setup'
require 'faraday'
require 'faraday_middleware'
require 'logger'
require 'code42/error'

module Code42
  class Connection
    attr_accessor :host, :port, :scheme, :path_prefix, :username, :password, :adapter, :token, :verify_https, :logger, :last_response

    def initialize(options = {})
      self.host         = options[:host]
      self.port         = options[:port]
      self.scheme       = options[:scheme]
      self.path_prefix  = options[:path_prefix]
      self.username     = options[:username]
      self.password     = options[:password]
      self.token        = options[:token] if options[:token]
      self.verify_https = !options[:verify_https].nil? ? options[:verify_https] : true
    end

    extend Forwardable

    delegate %i(host  port  path_prefix  scheme) => :adapter
    delegate %i(host= port= path_prefix= scheme=) => :adapter

    delegate %i(get post put delete) => :adapter

    def verify_https=(verify_https)
      adapter.ssl[:verify] = verify_https
    end

    def verify_https
      adapter.ssl[:verify]
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def adapter
      @adapter ||= Faraday.new do |f|
        f.request  :multipart
        f.request  :json

        f.adapter  :net_http

        f.response :json
      end
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

    def make_request(method, *args, &block)
      begin
        @last_response = response = self.send(method, *args, &block)
        ActiveSupport::Notifications.instrument('code42.request', {
          method:   method,
          args:     args,
          response: response
        })
      rescue Faraday::Error::ConnectionFailed
        raise Code42::Error::ConnectionFailed
      end
      check_for_errors(response)
      response.body
    end

    def respond_to?(method_name, include_private = false)
      adapter.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION < "1.9"

    def respond_to_missing?(method_name, include_private = false)
      adapter.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION >= "1.9"

    private

    def check_for_errors(response)
      if response.status >= 400 && response.status < 600
        raise exception_from_response(response)
      end
    end

    def exception_from_response(response)
      body = Array(response.body).first
      klass =
        case response.status
        when 401
          Code42::Error::AuthenticationError
        when 403
          Code42::Error::AuthorizationError
        when 404
          Code42::Error::ResourceNotFound
        else
          if body.nil? || !body.has_key?('name')
            Code42::Error
          else
            exception_name = body['name'].downcase.camelize
            Code42::Error.const_defined?(exception_name) ? Code42::Error.const_get(exception_name) : Code42::Error::ServerError
          end
        end
      message = body ? body['description'] : "Status: #{response.status}"
      klass.new(message, response.status, response)
    end

    def method_missing(method_name, *args, &block)
      return super unless adapter.respond_to?(method_name)
      adapter.send(method_name, *args, &block)
    end
  end
end
