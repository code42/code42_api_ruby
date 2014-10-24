
describe Code42::ServerConnectionString do

  let(:valid_attributes) do
    {
        server_id: 2,
        connection_string: 'asdfasdf'
    }
  end

  subject(:server_connection_string) { Code42::ServerConnectionString.new(valid_attributes) }

  describe '#server_id' do
    it 'returns the server_id' do
      expect(server_connection_string.server_id).to eql valid_attributes[:server_id]
    end
  end

  describe '#connection_string' do
    it 'returns the connection string' do
      expect(server_connection_string.connection_string).to eql valid_attributes[:connection_string]
    end
  end

  describe '#server' do
    it 'returns the server for the associated id' do
      allow(server_connection_string).to receive(:server) { Code42::Server.new(id: valid_attributes[:server_id]) }

      resp = server_connection_string.server
      expect(resp).to be_a Code42::Server
      expect(resp.id).to eql valid_attributes[:server_id]
    end
  end
end