require "crashplan/ext/string"
require "crashplan/ext/hash"

module Crashplan
  module Resource
    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def attribute_translations
        @attribute_translations ||= {}
      end

      def serialize(data)
        translate_attributes(data, attribute_translations.invert, true)
      end

      def deserialize(data)
        translate_attributes(data, attribute_translations, false)
      end

      def translate_attributes(data, translations, serialize = false)
        new_hash = {}
        data.each do |k,v|
          if translations.has_key?(k)
            new_key = translations[k]
          else
            new_key = serialize ? k.to_s.camelize : k.underscore.to_sym
          end
          new_hash[new_key] = v
        end
        new_hash
      end

      def translate_attribute(serialized, deserialized)
        attribute_translations[serialized.to_s] = deserialized
      end
    end

    def initialize(data = {})
      @attributes = []
      data.each do |key, value|
        @attributes << key.to_sym
        unless self.respond_to?("#{key}=".to_sym)
          self.class.send :define_method, "#{key}=".to_sym do |v|
            instance_variable_set("@" + key.to_s, v)
          end
        end
        unless self.respond_to?("key".to_sym)
          self.class.send :define_method, key.to_sym do
            instance_variable_get("@" + key.to_s)
          end
        end
        self.send("#{key}=", value)
      end
    end
  end
end
