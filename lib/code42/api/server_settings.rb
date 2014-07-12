module Code42
  module API
    module ServerSettings
      def server_settings(id)
        object_from_response(Code42::ServerSettings, :get, "serverSettings/#{id}")
      end

      def update_server_settings(id, attrs)
        put("serverSettings/#{id}", attrs)
      end
    end
  end
end
