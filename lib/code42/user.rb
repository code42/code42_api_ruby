require 'date'

module Code42
  class User < Resource

    attribute :id, :from => 'userId'
    attribute :uid, :from => 'userUid'
    attribute :org_id
    attribute :updated_at, :from => 'modificationDate', :as => DateTime
    attribute :created_at, :from => 'creationDate', :as => DateTime
    attribute :status, :username, :email, :first_name, :last_name, :quota_in_bytes, :org_id, :org_uid, :org_name, :active, :blocked, :email_promo, :invited, :org_type, :username_is_an_email, :customer_id

    def self.create(attributes)
      client.create_user(attributes)
    end

    def update(attributes)
      client.update_user(id, attributes)
    end

    def delete
      client.delete_user(id)
    end

    # Returns the org associated with this user
    # @return [Code42::User]
    def org
      client.org(org_id)
    end

    # Returns the roles associated with this user
    # @return [Code42::RoleCollection]
    def roles
      client.user_roles(id)
    end

    # Assigns a role to this user
    # @return [Code42::Role]
    def assign_role(attrs = {})
      attrs.merge!(user_id: id)
      client.assign_role(attrs)
    end

    def block
      client.block_user(user_id: id)
    end

    def unblock
      client.unblock_user(user_id: id)
    end
  end
end
