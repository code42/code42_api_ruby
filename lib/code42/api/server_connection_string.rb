module Code42
  module API
    module ServerConnectionString
      def server_connection_string(id)
        object_from_response(Code42::ServerConnectionString, :get, "serverConnectionString/#{id}")
      end
    end
  end
end