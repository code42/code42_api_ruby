module Crashplan
  class Client
    attr_accessor :host, :port, :https
    attr_reader :settings

    def initialize(options = {})
      @host     = options[:host]
      @port     = options[:port]
      @https    = options.has_key?(:https) ? options[:https] : true
    end

    def settings
      data = {}
      data[:host]  = host
      data[:port]  = port
      data[:https] = https
      data
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
