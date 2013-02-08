require "crashplan/ext/string"

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

      def from_response(response, client = nil)
        deserialize_and_initialize(response['data'], client)
      end

      def deserialize_and_initialize(data, client = nil)
        new deserialize(data), client
      end


      # TODO: refactor these two methods
      def serialize(data)
        translations = attribute_translations.invert
        new_hash = {}

        data.each do |k,v|
          new_key = k.to_s.camelize
          if translations.has_key?(k)
            new_key = translations[k]
          end
          new_hash[new_key] = v
        end
        new_hash
      end

      def deserialize(data)
        translations = attribute_translations
        new_hash = {}

        data.each do |k,v|
          new_key = k.underscore.to_sym
          if translations.has_key?(k)
            new_key = translations[k]
          end
          new_hash[new_key] = v
        end
        new_hash
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
      self.client = client
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
