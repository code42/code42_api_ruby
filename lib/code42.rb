require "date"
require "active_support/core_ext/array/extract_options"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/object/try"
require "code42/version"
require "code42/client"
require "code42/settings"
require "code42/error"
require "code42/connection"
require "code42/attribute"
require "code42/attribute_serializer"
require "code42/resource"
require "code42/org"
require "code42/user"
require "code42/computer"
require "code42/diagnostic"
require "code42/ping"
require "code42/token"
require "code42/role"
require "code42/role_collection"
require "code42/token_validation"

module Code42
  class << self
    def client
      @client ||= Code42::Client.new
    end

    def use_extension(module_name)
      Client.send(:include, module_name::ClientMethods) if defined?(module_name::ClientMethods)
      self.send(:include, module_name::Resources) if defined?(module_name::Resources)
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
