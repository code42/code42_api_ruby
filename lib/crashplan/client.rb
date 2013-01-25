module Crashplan
  class Client
    attr_accessor :host, :port

    def initialize(options = {})
      @host = options[:host]
      @port = options[:port]
    end

    def settings
      settings = {}
      settings[:host] = host
      settings[:port] = port
      settings
    end

    def user
      check_settings
      get '/api/user/my'
    end

    def org
      check_settings
      get '/api/org/my'
    end

    private

    def get(path)
      if path =~ /user/
        'my user'
      else
        'my org'
      end
    end

    def check_settings
      raise "Host is not set" if host.nil?
      raise "Port is not set" if port.nil?
    end
  end
end
