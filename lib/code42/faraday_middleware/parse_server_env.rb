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
require 'faraday_middleware/response_middleware'

module Code42
  module FaradayMiddleware
    class ParseServerEnv < ::FaradayMiddleware::ResponseMiddleware
      dependency 'json'

      define_parser do |body|
        new_body = body.clone
        new_body.gsub! "'", '"' # Remove single-quotes and replace with double-quotes. JSON parser cannot parse single quotes.
        new_body.gsub! /(\w+):/, '"\1":' # Surround keys with double-quotes.
        new_body.sub! 'window.serverEnv = ', '' # Trim off variable assignment.
        new_body.chomp! ";\n" # Trim off tailing semicolon and newline characters.

        # noinspection RubyStringKeysInHashInspection
        begin
          { 'data' => ::JSON.parse(new_body) }
        rescue
          body
        end
      end

      SERVER_ENV_PATH = '/api/ServerEnv'
      MIME_TYPE = 'text/javascript'

      def parse_response?(env)
        # noinspection RubyResolve
        SERVER_ENV_PATH.casecmp(env.url.path) == 0 and env.response_headers['content-type'].include? MIME_TYPE
      end
    end
  end
end
