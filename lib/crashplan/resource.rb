require "crashplan/ext/string"

module Crashplan
  class Resource
    class << self
      def attribute_translations
        @attribute_translations ||= {}
      end

      def from_response(response, client = nil)
        deserialize_and_initialize(response['data'], client)
      end

      def deserialize_and_initialize(data, client = nil)
        new deserialize(data), client
      end

      def serialize_attribute(name, value)
        new_name = serialize_attribute_key(name)
        Hash[new_name, value]
      end

      def deserialize_attribute(name, value)
        new_name = deserialize_attribute_key(name)
        Hash[new_name, value]
      end

      def serialize_attribute_key(key)
        reverse_attribute_translations[key] || key.to_s.camelize
      end

      def deserialize_attribute_key(key)
        attribute_translations[key] || key.underscore.to_sym
      end

      def reverse_attribute_translations
        attribute_translations.invert
      end

      # TODO: refactor these two methods
      def serialize(data)
        serialized = {}
        data.each do |k,v|
          serialized.merge! serialize_attribute(k,v)
        end
        serialized
      end

      def deserialize(data)
        deserialized = {}
        data.each do |k,v|
          deserialized.merge! deserialize_attribute(k,v)
        end
        deserialized
      end

      def translate_attribute(serialized, deserialized)
        attribute_translations[serialized.to_s] = deserialized
      end

      def attributes
        @attributes ||= []
      end

      def attribute(*args)
        options = args.extract_options!
        if options.has_key?(:as)
          name = args.first
          attributes << name
          attribute_translations[name.to_s.camelize] = options[:as]
        else
          attributes.push(*args)
        end
      end
    end

    attr_reader :attributes
    attr_accessor :client

    def initialize(data = {}, client = nil)
      self.client = client || Crashplan.client
      @attributes = {}
      data.each do |key, value|
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
        @attributes[key.to_sym] = send(key.to_sym)
      end
    end
  end
end
