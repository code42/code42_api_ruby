module Crashplan
  class Settings
    attr_accessor :host, :port, :https, :api_root, :username, :password

    def initialize(options = {})
      @host     = options[:host]
      @port     = options[:port]
      @https    = !!options[:https]
      @api_root = options[:api_root]
      @username = options[:username]
      @password = options[:password]
    end

    def all
      settings = {}
      settings[:host]     = host
      settings[:port]     = port
      settings[:https]    = https
      settings[:api_root] = api_root
      settings[:username] = username
      settings[:password] = password
      settings
    end

    def scheme
      https ? 'https' : 'http'
    end

    def base_url
      "#{scheme}://#{host}:#{port}#{api_root}"
    end

    def valid?
      host && port && api_root
    end
  end
end
