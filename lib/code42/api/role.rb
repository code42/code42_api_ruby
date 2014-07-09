module Code42
  module API
    module Role
      ### Roles :post, :get ###

      # Assigns a role to a user
      # @return [Code42::Role] The assigned role
      # @param attrs [Hash] A hash of attributes for assigning a user role
      # @example
      #   client.assign_role(:user_id => 2, :role_name => 'Admin')
      def assign_role(attrs = {})
        object_from_response(Code42::Role, :post, 'UserRole', attrs)
      end

      # Returns a list of roles for a given user
      # @return [Code42::RoleCollection] A collection of matching roles
      # @param id [String, Integer] The id of the user to return roles for
      def user_roles(id = 'my')
        collection_from_response(Code42::RoleCollection, Code42::Role, :get, "userRole/#{id}")
      end

      # TODO: The REST resource should really take the userId in the url path, not as a query param
      # Unassign a role from a user
      # @return true if role was unassigned
      # @param id [String, Integer] The id of the user to return roles for
      # @param id [String] The role name to unassign
      # @example
      #   client.unassign_role(2, 'Admin')
      def unassign_role(id, role_name)
        delete('UserRole', { :userId => id, :roleName => role_name })
      end

    end
  end
end

