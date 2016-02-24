# Copyright (c) 2016 Code42, Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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
      client.users + client.users(active: false)
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

    # Delete a role from this user
    def unassign_role(role_name)
      client.unassign_role(id, role_name)
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
      client.user(id, active: false)
    end

    def permissions
      client.permissions
    end

  end
end
