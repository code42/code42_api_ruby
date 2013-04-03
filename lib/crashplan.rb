require "date"
require "active_support/core_ext/array/extract_options"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/object/try"
require "crashplan/version"
require "crashplan/client"
require "crashplan/settings"
require "crashplan/error"
require "crashplan/connection"
require "crashplan/attribute"
require "crashplan/attribute_serializer"
require "crashplan/resource"
require "crashplan/org"
require "crashplan/user"
require "crashplan/computer"
require "crashplan/ping"
require "crashplan/token"
require "crashplan/role"
require "crashplan/role_collection"
require "crashplan/token_validation"

module Crashplan
  class << self
    def client
      @client ||= Crashplan::Client.new
    end

    def configure
      yield self.settings
      self
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

    private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
