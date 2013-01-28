module Crashplan
  class User
    attr_accessor :id, :uid, :status, :username, :email, :first_name, :last_name, :quota_in_bytes, :org_id, :org_uid, :org_name, :active, :blocked, :email_promo, :invited, :org_type, :username_is_an_email, :created_at, :updated_at

    def initialize(attrs = {})
      attrs ||= {}
      self.id                   = attrs["userId"]
      self.uid                  = attrs["userUid"]
      self.status               = attrs["status"]
      self.username             = attrs["username"]
      self.email                = attrs["email"]
      self.first_name           = attrs["firstName"]
      self.last_name            = attrs["lastName"]
      self.quota_in_bytes       = attrs["quotaInBytes"]
      self.org_id               = attrs["orgId"]
      self.org_uid              = attrs["orgUid"]
      self.org_name             = attrs["orgName"]
      self.active               = attrs["active"]
      self.blocked              = attrs["blocked"]
      self.email_promo          = attrs["emailPromo"]
      self.invited              = attrs["invited"]
      self.org_type             = attrs["orgType"]
      self.username_is_an_email = attrs["usernameIsAnEmail"]
      self.created_at           = attrs["creationDate"]
      self.updated_at           = attrs["modificationDate"]
    end

    def created_at=(date)
      return if date.nil?
      @created_at = DateTime.parse(date)
    end

    def updated_at=(date)
      return if date.nil?
      @updated_at = DateTime.parse(date)
    end
  end
end
