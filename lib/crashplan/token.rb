require 'crashplan/resource'

module Crashplan
  class Token
    include Resource

    class << self
      def from_response(response)
        if response.is_a? Hash
          if response.has_key?('data')
            data = response['data']
            self.new deserialize(data)
          end
        elsif response.is_a? Array
          response.each do |r|
            if r.has_key?('name') && r.has_key?('description')
              raise CrashPlan::Error::AuthorizationError, r['description']
            end
          end
        end
      end

      def from_string(token_string)
        tokens = token_string.split('-')
        new(cookie_token: tokens[0],
            url_token: tokens[1])
      end

      def deserialize(data)
        result = {}
        result[:cookie_token] = data[0]
        result[:url_token]    = data[1]
        result
      end
    end

    def to_s
      token_string
    end

    def token_string
      [cookie_token, url_token].join('-')
    end
  end
end
