module Crashplan
  class TokenValidation < Resource

    attribute :valid, :username

    def valid?
      valid
    end
  end
end
