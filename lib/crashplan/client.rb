module Crashplan
  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    def user
      check_settings
      get '/api/user/my'
    end

    def org
      check_settings
      get '/api/org/my'
    end

    def connection
      Faraday.new do |f|
        f.host        = settings.host
        f.port        = settings.port
        f.scheme      = settings.scheme
        f.path_prefix = settings.api_root
        f.basic_auth(settings.username, settings.password)
      end
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
      raise "Host is not set" if settings.host.nil?
      raise "Port is not set" if settings.port.nil?
    end
  end
end
