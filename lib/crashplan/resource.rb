module Crashplan
  class Resource
    class << self
      def from_response(response, client = nil)
        deserialize_and_initialize(response['data'], client)
      end

      def deserialize_and_initialize(data, client = nil)
        new deserialize(data), client
      end

      def serialize(data)
        data.inject({}) { |o, ary| o.merge! serializer.serialize(*ary) }
      end

      def deserialize(data)
        data.inject({}) { |o, ary| o.merge! serializer.deserialize(*ary) }
      end

      def serializer
        @serializer ||= Crashplan::AttributeSerializer.new
      end

      def attributes
        @attributes ||= []
      end

      def attribute(*args)
        options = args.extract_options!
        if options.has_key?(:from)
          from = options[:from].to_s
          to = args.first
          serializer.add_exception(from, to)
          attributes << to
        else
          attributes.push *args
        end
      end
    end

    attr_accessor :client, :attributes

    def initialize(data = {}, client = nil)
      self.client = client || Crashplan.client
      self.attributes = {}
      data.each do |key, value|
        unless self.respond_to?("#{key}=".to_sym)
          self.class.instance_eval { attr_writer key.to_sym }
        end
        unless self.respond_to?("#{key}".to_sym)
          self.class.instance_eval { attr_reader key.to_sym }
        end
        self.send("#{key}=", value)
        attributes[key.to_sym] = send(key.to_sym)
      end
    end
  end
end
