module Crashplan
  class User
    attr_accessor :id, :uid, :status

    def initialize(attrs = {})
      attrs ||= {}
      self.id     = attrs["userId"]
      self.uid    = attrs["userUid"]
      self.status = attrs["status"]
    end
  end
end
