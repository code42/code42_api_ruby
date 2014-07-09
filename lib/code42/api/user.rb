module Code42
  module API
    module User
      ### Users :post, :get ###

      # Creates a user
      # @return [Code42::User] The created user
      # @param attrs [Hash] A hash of attributes to assign to created user
      # @example
      #   client.create_user(:username => 'testuser', password: 'letmein', email: 'test@example.com', org_id: 3)
      def create_user(attrs = {})
        object_from_response(Code42::User, :post, "user", attrs)
      end

      # Updates a user
      # @returns [Code42::User] The updated user
      # @param id [integer] The user id to be updated
      # @param attrs [Hash] A hash of attributes to update
      # @example
      #   client.update_user(2, email_promo: true, first_name: 'John')
      def update_user(id, attrs = {})
        object_from_response(Code42::User, :put, "user/#{id}", attrs)
      end

      # Returns information for a given user
      # @return [Code42::User] The requested user
      # @param id_or_username [String, Integer] A code42 user ID or username
      def user(id_or_username = "my", params = {})
        if id_or_username.is_a?(Fixnum) || id_or_username == 'my'
          find_user_by_id id_or_username, params
        else
          find_user_by_username id_or_username, params
        end
      end

      # Returns a user for a given id
      def find_user_by_id(id = 'my', params = {})
        object_from_response(Code42::User, :get, "user/#{id}", params)
      end

      # Returns a user for a given username
      def find_user_by_username(username, params = {})
        params.merge!(username: username)
        users(params).first
      end

      # Returns a user for a given channel id
      # @return [Code42::User] The requested user
      # @param channel_id [String, Integer] A code42 User
      def find_user_by_channel_id(channel_id = 1)
        object_from_response(Code42::User, :get, "userChannel?channelCustomerId=#{channel_id}")
      end

      # Returns a list of up to 100 users
      # @return [Array] An array of matching users
      # @param params [Hash] A hash of parameters to match results against
      def users(params = {})
        params.merge!(key: 'users')
        objects_from_response(Code42::User, :get, 'user', params)
      end

      # Check if user exists with given username.
      def user_exists?(username)
        users(username: username).present?
      end

      # Block a user from logging in
      # @return true if blocked
      # @params id [Integer, String] The user ID you want to block
      def block_user(id)
        put("UserBlock/#{id}")
      end

      # Unblock a previously blocked user
      # @return true if unblocked
      # @params id [Integer, String] The user ID you want to unblock
      def unblock_user(id)
        delete("UserBlock/#{id}")
      end

      def deactivate_user(id)
        put("UserDeactivation/#{id}")
      end

      def activate_user(id)
        delete("UserDeactivation/#{id}")
      end

      # Returns a list of permissions for the session user
      # @return [Array] An array of matching permissions
      def permissions
        objects_from_response(Code42::Permission, :get, 'permission')
      end

    end
  end
end
