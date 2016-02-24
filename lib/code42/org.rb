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
  class Org < Resource

    attribute :id, :from => 'orgId'
    attribute :uid, :from => 'orgUid'
    attribute :name, :from => 'orgName'
    attribute :parent_id, :from => 'parentOrgId'
    attribute :created_at, :from => 'creationDate', :as => DateTime
    attribute :updated_at, :from => 'modificationDate', :as => DateTime
    attribute :customer_id
    attribute :active
    attribute :blocked

    def self.create(attrs = {})
      client.create_org(attrs)
    end

    def self.find_by_id(id, attrs = {})
      find_active_by_id(id, attrs) || find_inactive_by_id(id, attrs)
    end

    def self.find_active_by_id(id, attrs = {})
      client.org(id, attrs)
    end

    def self.find_inactive_by_id(id, attrs = {})
      client.org(id, attrs.merge(active: false))
    end

    def self.find_by_name(name, attrs = {})
      find_active_by_name(name, attrs) || find_inactive_by_name(name, attrs)
    end

    def self.find_active_by_name(name, attrs = {})
      client.find_org_by_name(name, attrs.merge(active: true))
    end

    def self.find_inactive_by_name(name, attrs = {})
      client.find_inactive_org_by_name name, attrs
    end

    def self.find_all_orgs
      find_all_active_orgs + find_all_inactive_orgs
    end

    def self.find_all_active_orgs
      client.orgs
    end

    def self.find_all_inactive_orgs
      client.orgs(active: false)
    end

    def users
      client.users(org_id: id)
    end

    def update(attrs = {})
      client.update_org(id, attrs)
    end

    def activate
      client.activate_org(id)
      client.org id
    end

    def deactivate
      client.deactivate_org(id)
      client.org(id, active: false)
    end

    def block
      client.block_org(id)
      client.org id
    end

    def unblock
      client.unblock_org(id)
      client.org id
    end

    def create_user(attrs = {})
      attrs.merge!(org_id: id)
      client.create_user(attrs)
    end
  end
end
