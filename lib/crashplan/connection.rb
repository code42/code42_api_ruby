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
      @adapter     = Faraday.new do |f|
        f.host = @host
        f.port = @port
        f.path_prefix = @path_prefix
        f.basic_auth(@username, @password)
      end
    end
  end
end
