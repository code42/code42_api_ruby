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
require "code42/product_license"
require "code42/server_settings"
require "code42/destination"
require "code42/server"
require "code42/server_connection_string"

module Code42
  class << self
    def client
      @client ||= Code42::Client.new
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

class RequestLogger < Faraday::Request
  def call(env)
    debug('request') { dump_body(env[:body]) }
    super
  end
end

class BodyLogger < Faraday::Response::Logger
  def call(env)
    debug('response') { dump_body(env[:body]) }
    super
  end

  def on_complete(env)
    debug('response') { dump_body(env[:body]) }
    super
  end

  def dump_body(body)
    if body.respond_to?(:to_str)
      body.to_str
    else
      pretty_inspect(body)
    end
  end

  def pretty_inspect(body)
    require 'pp' unless body.respond_to?(:pretty_inspect)
    body.pretty_inspect
  end
end
