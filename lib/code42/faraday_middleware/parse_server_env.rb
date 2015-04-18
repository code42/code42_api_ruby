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
