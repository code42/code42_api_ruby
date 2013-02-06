module Crashplan
  class UserRole
    include Resource

    attribute :role_id, :as => :id
    attribute :role_name, :as => :name
    attribute :creation_date, :as => :created_at
    attribute :modification_date, :as => :updated_at

    def created_at=(date)
      @created_at = DateTime.parse(date)
    end

    def updated_at=(date)
      @updated_at = DateTime.parse(date)
    end

    def permissions=(permissions = [])
      @permissions = permissions.map { |p| p['permission'] }
    end
  end
end
