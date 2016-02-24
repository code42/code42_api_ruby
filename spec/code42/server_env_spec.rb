# Copyright (c) 2016 Code42, Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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

    it 'should serialize json object into a valid ServerEnv object' do
      server_env = Code42::ServerEnv.deserialize_and_initialize(response_data)
      expect(server_env.product_version).to eql '4.3.0'
    end
  end
end
