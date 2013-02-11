require 'date'

module Crashplan
  class User < Resource

    attribute :user_id, :as => :id
    attribute :user_uid, :as => :uid
    attribute :modification_date, :as => :updated_at
    attribute :creation_date, :as => :created_at
    attribute :status, :username, :email, :first_name, :last_name, :quota_in_bytes, :org_id, :org_uid, :org_name, :active, :blocked, :email_promo, :invited, :org_type, :username_is_an_email

    def created_at=(date)
      return if date.nil?
      @created_at = DateTime.parse(date)
    end

    def updated_at=(date)
      return if date.nil?
      @updated_at = DateTime.parse(date)
    end

    # Returns the org associated with this user
    # @return [Crashplan::User]
    def org
      client.org(org_id)
    end

    # Returns the roles associated with this user
    # @return [Crashplan::RoleCollection]
    def roles
      client.user_roles(id)
    end

    # Assigns a role to this user
    # @return [Crashplan::Role]
    def assign_role(attrs = {})
      attrs.merge!(user_id: id)
      client.assign_role(attrs)
    end
  end
end
