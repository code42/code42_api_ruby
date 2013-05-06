module Code42
  class Settings
    attr_accessor :host, :port, :https, :api_root, :username, :password, :token, :verify_https, :debug

    def initialize(options = {})
      options.symbolize_keys!
      self.host     = options[:host]
      self.port     = options[:port]
      self.https    = !options[:https].nil? ? options[:https] : true
      self.verify_https = !options[:verify_https].nil? ? options[:verify_https] : true
      self.api_root = options[:api_root] || '/api'
      self.username = options[:username]
      self.password = options[:password]
      self.token    = options[:token]
      self.debug    = options[:debug]
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
      raise Error unless valid?
      "#{scheme}://#{host}:#{port}#{api_root}"
    end

    def valid?
      host && port && api_root
    end
  end
end
