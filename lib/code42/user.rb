require 'date'

module Code42
  class User < Resource

    attribute :id, :from => 'userId'
    attribute :uid, :from => 'userUid'
    attribute :org_id
    attribute :updated_at, :from => 'modificationDate', :as => DateTime
    attribute :created_at, :from => 'creationDate', :as => DateTime
    attribute :role, :from => 'roleName' # from plan_user_Dto
    attribute :status, :username, :email, :first_name, :last_name, :quota_in_bytes, :org_id, :org_uid, :org_name, :active, :blocked, :email_promo, :invited, :org_type, :username_is_an_email, :customer_id

    def self.create(attributes)
      client.create_user(attributes)
    end

    def self.find_by_id(id)
      client.find_user_by_id id
    end

    def self.find_by_name(user_name)
      client.user user_name
    end

    def self.find_all_users
      all_users = client.users
      all_users += client.users :active => false
    end

    def update(attributes)
      client.update_user(id, attributes)
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
      client.block_user(id)
      client.user id
    end

    def unblock
      client.unblock_user(id)
      client.user id
    end

    def activate
      client.activate_user(id)
      client.user id
    end

    def deactivate
      client.deactivate_user(id)
      client.user(id, :active => false)
    end
  end
end
