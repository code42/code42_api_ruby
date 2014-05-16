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
      org = client.org(id, attrs)
      if org.nil?
        attrs.merge!(:active => false)
        org = client.org(id, attrs)
      end
      org
    end

    def self.find_active_by_id(id, attrs = {})
      client.org(id, attrs)
    end

    def self.find_inactive_by_id(id, attrs = {})
      client.org(id, attrs.merge!(:active => false))
    end

    def self.find_by_name(name, attrs = {})
      org = client.find_org_by_name(name, attrs)
      if org.nil?
        org = find_inactive_by_name(name, attrs)
      end
      org
    end

    def self.find_active_by_name(name, attrs = {})
      client.find_org_by_name(name, attrs.merge!(:active => true))
    end

    def self.find_inactive_by_name(name, attrs = {})
      client.find_inactive_org_by_name name, attrs
    end

    def self.find_all_orgs
      orgs = find_all_active_orgs
      orgs += find_all_inactive_orgs
    end

    def self.find_all_active_orgs
      client.orgs
    end

    def self.find_all_inactive_orgs
      client.orgs :active => false
    end

    def users
      client.users(:org_id => id)
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
      client.org(id, :active => false)
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
      attrs.merge!(:org_id => id)
      client.create_user(attrs)
    end
  end
end
