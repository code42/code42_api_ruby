# Copyright (c) 2016 Code42, Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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
