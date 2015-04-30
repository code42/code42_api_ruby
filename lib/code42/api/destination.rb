module Code42
  module API
    module Destination
      def destinations(name = nil)
        objects_from_response(Code42::Destination, :get, "destinations#{"?name=#{name}" if name}", key: 'destinations')
      end

      def destination(id)
        object_from_response(Code42::Destination, :get, "destination/#{id}")
      end

      def create_destination(attrs)
        response = post('Destination', attrs)
        response['data'].first if response && response['data'].is_a?(Array)
      end
    end
  end
end
