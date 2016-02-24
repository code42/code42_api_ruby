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
describe Code42::Server do
  let(:valid_attributes) do
    {
        id: 1234,
        guid: 12345,
        name: 'test_server',
        type: 'SERVER',
        version: '3.6.3',
        online: true,
        out_of_date: false,
        accepting_inbound_backup: true,
        balancing_data: true,
        accepting_new_computers: true,
        db_empty: false,
        cluster_server_id: 42,
        destination_id: 21,
        destination_name: 'destination',
        provider_destination_name: 'provider_destination',
        primary_address: '127.0.0.1',
        secondary_address: '192.168.1.150',
        website_host: '127.0.0.1:4280',
        store_point_count: 2,
        total_bytes: 1234567890,
        used_bytes: 123456789,
        used_percentage: 10,
        free_bytes: 1234567890 - 123456789,
        free_percentage: 90,
        cold_bytes: 0,
        cold_percentage_of_used: 0,
        cold_percentage_of_total: 0,
        archive_bytes: 0,
        selected_bytes: 0,
        remaining_bytes: 0,
        inbound_bandwidth: 0,
        outbound_bandwidth: 0,
        org_count: 10,
        user_count: 100,
        licensed_user_count: 99,
        computer_count: 150,
        backup_computer_count: 100,
        online_computer_count: 5,
        backup_session_count: 5
    }
  end

  subject(:server) { Code42::Server.new valid_attributes }

  let(:client) do
    client = double(Code42::Client)
    allow(client).to receive(:server_connection_string) { 'asdfasdf' }
    client
  end

  describe '#id' do
    it 'should return correct id' do
      server.id.should == 1234
    end
  end

  describe '#connection_string' do
    it 'should return the server connection string' do
      allow(server).to receive(:client) { client }
      expect(server.connection_string).to eql 'asdfasdf'
    end
  end
end
