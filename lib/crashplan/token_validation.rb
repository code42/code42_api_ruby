module Crashplan
  class TokenValidation
    include Resource

    attribute :valid, :username

    def valid?
      valid
    end
  end
end
