require 'faraday'

module Crashplan
  class Connection
    attr_accessor :host, :port, :scheme, :path_prefix, :username, :password, :adapter

    def initialize(options = {})
      @host        = options[:host]
      @port        = options[:port]
      @scheme      = options[:scheme]
      @path_prefix = options[:path_prefix]
      @username    = options[:username]
      @password    = options[:password]
      @adapter     = Faraday.new

      @adapter.host = @host
      @adapter.port = @port
      @adapter.scheme = @scheme
      @adapter.path_prefix = @path_prefix
      @adapter.basic_auth(@username, @password) if @username && @password
    end

    def get(path)
      response = adapter.get(path)
      response.body
    end

    def post(path, data)
      response = adapter.post do |r|
        r.path = path
        r.headers['Content-Type'] = "application/json"
        r.body = data.to_json
      end
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
