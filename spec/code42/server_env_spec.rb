describe Code42::ServerEnv do
  describe '#deserialize_and_initialize' do
    let(:response_data) do
      JSON.parse <<-JSON
      {
        "version": 1427864400430,
        "productVersion": "4.3.0",
        "clientProductVersion": "4.2.0",
        "spClientProductVersion": "4.2.0",
        "commerceVersion": "",
        "clusterType":
          {
            "consumer": false,
            "business": false,
            "enterprise": true
          },
        "serverType":
          {
            "master": true,
            "storage": false
          },
        "env":
          {
            "dev": true, "prd": false, "stg": false, "beta": false
          },
        "constants":
          {
            "cpOrgId": 42,
            "proOrgId": 5
          },
        "serverId": 3,
        "serverGuid": "7201",
        "clusterServerId": 1,
        "portPrefix": 72,
        "ssoAuthEnabled": false,
        "NOTE": "ssl, queryLimited, hasLoggedIn, and defaultAdminPassword may/will change after login so this information should only be used on login or shortly after",
        "ssl": true,
        "hasMlk": true,
        "hasLoggedIn": true,
        "defaultAdminPassword": true,
        "queryLimited": false,
        "statsEnabled": true,
        "secureKeystoreLocked": false,
        "httpPort": 7280,
        "httpsPort": 7285,
        "locale": "en_US"
      }
      JSON
    end

    it 'should translate roleId to id' do
      server_env = Code42::ServerEnv.deserialize_and_initialize(response_data)
      expect(server_env.product_version).to eql '4.3.0'
    end
  end
end
