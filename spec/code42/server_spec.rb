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