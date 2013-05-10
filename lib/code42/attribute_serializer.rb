module Code42
  class AttributeSerializer
    def add_exception(from, to)
      exceptions << AttributeSerializerException.new(from, to)
    end

    def attributes
      @attributes ||= []
    end

    def <<(attribute)
      add_exception attribute.from, attribute.to
      attributes << attribute
    end

    def exceptions
      @exceptions ||= AttributeSerializerExceptions.new
    end

    def serialize(key, value)
      Hash[serialize_key(key), serialize_value(value)]
    end

    def serialize_value(value)
      if value.respond_to? :serialize
        value.serialize
      elsif value.is_a? DateTime
        value.to_s
      elsif value.is_a? Hash
        value.inject({}) do |h,a|
          h.merge! serialize(a[0], a[1])
        end
      elsif value.is_a? Array
        value.map do |item|
          serialize_value(item)
        end
      else
        value
      end
    end

    def deserialize(key, value)
      Hash[deserialize_key(key), deserialize_value(key, value)]
    end

    def deserialize_key(key)
      if exception = exception_from(key)
        exception.to
      else
        key.underscore.to_sym
      end
    end

    def deserialize_value(key, value)
      if klass = attribute_for(key).try(:as)
        if attribute_for(key).try(:collection)
          klass.collection_from_response(value)
        elsif klass.respond_to?(:from_response)
          klass.from_response(value)
        elsif klass.respond_to?(:parse)
          klass.parse(value)
        else
          value
        end
      else
        if value.is_a?(Hash)
          value.inject({}) do |h,a|
            h.merge! deserialize(a[0], a[1])
          end
        else
          value
        end
      end
    end

    def serialize_key(key)
      if exception = exception_to(key)
        exception.from
      else
        key.to_s.camelize(:lower)
      end
    end

    def attribute_for(key)
      key = key.to_s
      attributes.detect { |a| a.to.to_s == key.to_s || a.from.to_s == key.to_s }
    end

    def exception_to(key)
      exceptions.to(key)
    end

    def exception_from(key)
      exceptions.from(key)
    end
  end

  class AttributeSerializerExceptions
    include Enumerable

    def initialize(exceptions = [])
      @exceptions = exceptions
    end

    def <<(exception)
      @exceptions << exception
    end

    def from(value)
      detect { |e| e.from == value }
    end

    def to(value)
      detect { |e| e.to == value }
    end

    def each(&block)
      @exceptions.each do |exception|
        if block_given?
          block.call exception
        else
          yield exception
        end
      end
    end
  end

  class AttributeSerializerException < Struct.new(:from, :to); end
end
