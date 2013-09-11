module Code42
  class ServerConnectionString < Resource
    def server
      client.server(server_id)
    end
  end
end
