module Code42
  module API
    module Token
      ### Authentication With Tokens :post, :get, :delete ###

      # Gets a token for the currently authorized user
      def get_token
        object_from_response(Code42::Token, :post, "authToken")
      end

      def apply_mlk(mlk, attrs)
        settings.mlk = mlk
        response = object_from_response(Code42::Token, :post, 'authToken', attrs)
        settings.mlk = nil
        response
      end

      # Returns LoginToken and ServerUrl
      # @return [CrashPlan::Token] Token to pass to ServerUrl's AuthToken resource
      def get_login_token
        object_from_response(Code42::Token, :post, "loginToken")
      end

      # Validates an authorization token
      # @return [Code42::TokenValidation]
      # @param token [Code42::Token, String] The token to validate
      def validate_token(token)
        object_from_response(Code42::TokenValidation, :get, "authToken/#{token.to_s}")
      end

      # Manually expires a token
      # @param token [Code42::Token, String] A token to expire (leave blank to expire currently used token)
      def delete_token(token = nil)
        token = token || settings.token
        delete "authToken/#{token.to_s}"
      end
    end
  end
end
