module Code42
  module API
    module StorePoint

      def find_store_points_by_name(name, params = {})
        objects_from_response(Code42::StorePoint, :get, 'storePoint', params.merge(key: 'storepoints', q: name))
      end

      def find_store_point_by_id(id, params = {})
        object_from_response(Code42::StorePoint, :get, "storePoint/#{id}", params)
      end

      def store_points(params = {})
        objects_from_response(Code42::StorePoint, :get, 'storePoint', params.merge(key: 'storepoints'))
      end

      def update_store_point(id, params)
        object_from_response(Code42::StorePoint, :put, "storePoint/#{id}", params)
      end
    end
  end
end
