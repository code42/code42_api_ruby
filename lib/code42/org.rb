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

    def self.create(attrs = {})
      client.create_org(attrs)
    end

    def self.find_by_name(name)
      client.find_org_by_name(name)
    end

    def users
      client.users(org_id: id)
    end

    def update(attrs = {})
      client.update_org(id, attrs)
    end

    def delete
      client.delete_org(id)
    end

    def create_user(attrs = {})
      attrs.merge!(org_id: id)
      client.create_user(attrs)
    end
  end
end
