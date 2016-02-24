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
require 'date'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'
require 'active_support/notifications'
require 'code42/version'
require 'code42/client'
require 'code42/settings'
require 'code42/error'
require 'code42/connection'
require 'code42/attribute'
require 'code42/attribute_serializer'
require 'code42/resource'
require 'code42/org'
require 'code42/user'
require 'code42/computer'
require 'code42/diagnostic'
require 'code42/ping'
require 'code42/token'
require 'code42/role'
require 'code42/role_collection'
require 'code42/token_validation'
require 'code42/permission'
require 'code42/product_license'
require 'code42/server_settings'
require 'code42/destination'
require 'code42/server'
require 'code42/server_env'
require 'code42/server_connection_string'
require 'code42/store_point'

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

    def respond_to_missing?(method_name, include_private=false)
      client.respond_to?(method_name, include_private)
    end

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
