module Code42
  module API
    module Server
      def servers(params = {})
        objects_from_response(Code42::Server, :get, 'server', params.merge(key: 'servers'))
      end

      def server(id, params = {})
        if id.is_a? Fixnum
          object_from_response(Code42::Server, :get, "server/#{id}", params)
        elsif id.is_a? String
          if id.eql? 'this'
            object_from_response(Code42::Server, :get, 'server/this', params)
          else
            servers(params.merge(q: id)).first
          end
        end
      end

      def create_server(attrs)
        object_from_response(Code42::Server, :post, 'server', attrs)
      end
    end
  end
end
