require 'crashplan/resource'

module Crashplan
  class AuthResource < Resource
    class << self
      def from_response(response)
        if response.has_key?('data')
          data = response['data']
          self.new deserialize(data)
        end
      end

      def deserialize(data)
        result = {}
        result[:cookie_token] = data[0]
        result[:url_token]    = data[1]
        result
      end
    end
  end
end
