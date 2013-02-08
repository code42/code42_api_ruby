module Crashplan
  class Org < Resource

    attribute :org_id, :as => :id
    attribute :org_uid, :as => :uid
    attribute :org_name, :as => :name
    attribute :parent_org_id, :as => :parent_id
    attribute :creation_date, :as => :created_at
    attribute :modification_date, :as => :updated_at

    def users
      client.users(org_id: id)
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
