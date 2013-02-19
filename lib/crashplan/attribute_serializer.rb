module Crashplan
  class AttributeSerializer
    def add_exception(from, to)
      exceptions << AttributeSerializerException.new(from, to)
    end

    def exceptions
      @exceptions ||= AttributeSerializerExceptions.new
    end

    def serialize(key, value)
      Hash[serialize_key(key), value]
    end

    def deserialize(key, value)
      Hash[deserialize_key(key), value]
    end

    def deserialize_key(attribute_key)
      if exceptions.contains_exception_from?(attribute_key)
        exceptions.from(attribute_key).to
      else
        attribute_key.underscore.to_sym
      end
    end

    def serialize_key(attribute_key)
      if exceptions.contains_exception_to?(attribute_key)
        exceptions.to(attribute_key).from
      else
        attribute_key.to_s.camelize(:lower)
      end
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

    def contains_exception_from?(value)
      !!from(value)
    end

    def contains_exception_to?(value)
      !!to(value)
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
