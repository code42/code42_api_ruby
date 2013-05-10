require 'code42/resource'

module Code42
  class Token < Resource

    class << self
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

    alias inspect to_s

    def to_s
      token_string
    end

    def token_string
      [cookie_token, url_token].join('-')
    end
  end
end
