module Code42
  module API
    module Server
      def servers
        objects_from_response(Code42::Server, :get, 'servers', key: 'servers')
      end

      def create_server(attrs)
        object_from_response(Code42::Server, :post, 'server', attrs)
      end
    end
  end
end
