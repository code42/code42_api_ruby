module Crashplan
  class TokenValidation
    include Resource

    def self.from_response(response)
      self.new deserialize(response['data'])
    end

    def valid?
      valid
    end
  end
end
