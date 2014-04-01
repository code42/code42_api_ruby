module Code42
  module API
    module PasswordReset
      # Send a password reset email to the user identified by +username_or_id+
      # @param username_or_id [String, Integer] The username or user_id of the user to whom the email should be sent.
      # @param view_url [String] the path of the password-reset form. Defaults to /console/password-reset.html
      def reset_password(username_or_id, view_url = nil)
        view_url ||= '/console/password-reset.html'
        params = { viewUrl: view_url }
        key    = username_or_id.to_i > 0 ? :userId : :username
        params[key] = username_or_id
        post("UserPasswordReset", params)
      end
    end
  end
end
