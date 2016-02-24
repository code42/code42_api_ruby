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
module Code42
  class Resource
    alias_method :inspect, :to_s

    class << self
      def from_response(response, client = nil)
        deserialize_and_initialize(response, client)
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
        @serializer ||= Code42::AttributeSerializer.new
      end

      def attribute(*args)
        options = args.extract_options!
        args.each do |name|
          serializer << Attribute.new(name, options)
        end
      end

      def collection_from_response(array)
        (array || []).map { |element| self.deserialize_and_initialize(element, self) }
      end
    end

    attr_accessor :client, :attributes

    def initialize(data = {}, client = nil)
      self.client = client || Code42.client
      self.attributes = {}
      data.each do |key, value|
        unless self.respond_to?("#{key}=".to_sym)
          self.class.instance_eval { attr_writer key.to_sym }
        end
        unless self.respond_to?("#{key}".to_sym)
          self.class.instance_eval { attr_reader key.to_sym }
        end
        self.send("#{key}=", value)
        attributes[key.to_sym] = self.send(key.to_sym)
      end
    end

    def serialize
      self.class.serialize attributes
    end
  end
end
