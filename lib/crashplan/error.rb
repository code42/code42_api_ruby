module Crashplan
  class Error < StandardError; end
  class Error::AuthenticationError < Error; end
end
