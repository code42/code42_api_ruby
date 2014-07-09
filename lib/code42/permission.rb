module Code42
  class Permission < Resource
    # @!attribute [rw] name
    #   @return [String] The name of the permission
    # @!attribute [rw] value
    #   @return [String] The value of the permission
    # @!attribute [rw] description
    #   @return [String] The description of the permission
    attribute :name
    attribute :value
    attribute :description
  end
end
