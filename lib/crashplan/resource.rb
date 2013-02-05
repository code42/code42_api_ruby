require "crashplan/ext/string"
require "crashplan/ext/hash"

module Crashplan
  class Resource
    @@attributes = {}

    def initialize(data = {})
      data.each do |key, value|
        self.class.send :define_method, "#{key}=".to_sym do |v|
          instance_variable_set("@" + key.to_s, v)
        end
        self.class.send :define_method, key.to_sym do
          instance_variable_get("@" + key.to_s)
        end
        self.send("#{key}=", value)
      end
    end

    class << self
      def deserialize(data)
        new_hash = {}
        data.each do |k,v|
          new_key = @@attributes.has_key?(k) ? @@attributes[k] : k.underscore
          new_hash[new_key.to_sym] = v
        end
        new_hash
      end

      def attribute(serialized, deserialized)
        @@attributes[serialized.to_s] = deserialized
      end
    end
  end
end
