module Code42
  module API
    module Destination
      def destinations
        objects_from_response(Code42::Destination, :get, 'destinations', key: 'destinations')
      end

      def destination(id)
        if id.is_a? Numeric
          object_from_response(Code42::Destination, :get, "destination/#{id}")
        else
          objects_from_response(Code42::Destination, :get, "destination?name=#{id}", key: 'destinations')
        end
      end

      def create_destination(attrs)
        response = post('Destination', attrs)
        response['data'].first if response && response['data'].is_a?(Array)
      end
    end
  end
end
