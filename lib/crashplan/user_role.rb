module Crashplan
  class UserRole < Resource

    # @!attribute [rw] id
    #   @return [Fixnum] The id of the role
    # @!attribute [rw] name
    #   @return [String] The name of the role
    # @!attribute [rw] user_id
    #   @return [Fixnum] The id of the user the role is assigned to
    # @!attribute [rw] created_at
    #   @return [DateTime] The timestamp for the time the role was assigned
    # @!attribute [rw] updated_at
    #   @return [DateTime] The timestamp for the time the role was updated

    attribute :user_id
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
