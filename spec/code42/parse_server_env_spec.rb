describe Code42::FaradayMiddleware::ParseServerEnv do
  describe '#parse' do
    let(:raw_javascript) do
      <<-JAVASCRIPT.gsub(/^ +/, '')
        window.serverEnv = {
        \tversion: 1427864400430,
        \tproductVersion: "4.3.0",
        \tclientProductVersion: "4.2.0",
        \tspClientProductVersion: "4.2.0",
        \tcommerceVersion: "",

        \tclusterType: {
        \t\tconsumer: false,
        \t\tbusiness: false,
        \t\tenterprise: true
        \t},

        \tserverType: {
        \t\tmaster: true,
        \t\tstorage: false
        \t},

        \tenv: {
        \t\tdev: true,
        \t\tprd: false,
        \t\tstg: false,
        \t\tbeta: false
        \t},

        \tconstants: {
        \t\tcpOrgId: 42,
        \t\tproOrgId: 5
        \t},

        \tserverId: 3,
        \tserverGuid: '7201',
        \tclusterServerId: 1,
        \tportPrefix: 72,
        \tssoAuthEnabled: false,

        \tNOTE: "ssl, queryLimited, hasLoggedIn, and defaultAdminPassword may/will change after login so this information should only be used on login or shortly after",
        \tssl: true,
        \thasMlk: true,
        \thasLoggedIn: true,
        \tdefaultAdminPassword: true,
        \tqueryLimited: false,
        \tstatsEnabled: true,
        \tsecureKeystoreLocked: false,
        \thttpPort: 7280,
        \thttpsPort: 7285,
        \tlocale: "en_US"
        };
      JAVASCRIPT
    end
    let(:expected_json) do
      JSON.parse <<-JSON
      {
        "data": {
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
      }
      JSON
    end

    it 'should parse valid javascript into a valid json' do
      json = Code42::FaradayMiddleware::ParseServerEnv.new.parse raw_javascript
      expect(json).to eql expected_json
    end
  end
end
