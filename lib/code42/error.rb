module Code42
  class Error < StandardError;
    attr_reader :status, :response

    def initialize(message = nil, status = nil, response = nil)
      super(message)

      @status   = status
      @response = response
    end
  end

  class Error::AuthenticationError < Error; end
  class Error::AuthorizationError < Error; end
  class Error::UsernameNotEmail < Error; end
  class Error::EmailInvalid < Error; end
  class Error::InvalidUsername < Error; end
  class Error::OrgNameMissing < Error; end
  class Error::OrgDuplicate < Error; end
  class Error::ParentOrgBlocked < Error; end
  class Error::ParentOrgNotActive < Error; end
  class Error::OrgNameTooShort < Error; end
  class Error::ConnectionFailed < Error; end
  class Error::ResourceNotFound < Error; end
  class Error::ServerError < Error; end
end
