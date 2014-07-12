module Code42
  class Server < Resource
    attribute :id, from: 'serverId'

    def connection_string
      client.server_connection_string(id)
    end
  end
end
