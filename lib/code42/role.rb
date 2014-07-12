module Code42
  class Role < Resource

    # @!attribute [rw] id
    #   @return [Fixnum] The id of the role
    # @!attribute [rw] name
    #   @return [String] The name of the role
    # @!attribute [rw] permissions
    #   @return [Array] A list of permissions for this role
    # @!attribute [rw] created_at
    #   @return [DateTime] The timestamp for the time the role was assigned
    # @!attribute [rw] updated_at
    #   @return [DateTime] The timestamp for the time the role was updated

    attribute :id, :from => :roleId
    attribute :name, :from => :roleName
    attribute :created_at, :from => :creationDate, :as => DateTime
    attribute :updated_at, :from => :modificationDate, :as => DateTime
    attribute :permissions

    def permissions=(permissions = [])
      @permissions = permissions.map { |p| p['permission'] }
    end

    def update(attrs = {})
      client.update_role(id, attrs)
    end

    def delete
      client.delete_role(id)
    end
  end
end
