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
        reverse_attribute_translations[key] || key.to_s.camelize(:lower)
      end

      def deserialize_attribute_key(key)
        attribute_translations[key] || key.underscore.to_sym
      end

      def reverse_attribute_translations
        attribute_translations.invert
      end

      def serialize(data)
        data.inject({}){ |o, ary| o.merge! serialize_attribute(*ary) }
      end

      def deserialize(data)
        data.inject({}){ |o, ary| o.merge! deserialize_attribute(*ary) }
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
          attribute_translations[name.to_s.camelize(:lower)] = options[:as]
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
