module Code42
  class ServerConnectionString < Resource
    attribute :server_id
    attribute :connection_string

    def server
      client.server(server_id)
    end
  end
end
