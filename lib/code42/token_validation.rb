module Code42
  class TokenValidation < Resource

    attribute :valid, :username

    def valid?
      valid
    end
  end
end
