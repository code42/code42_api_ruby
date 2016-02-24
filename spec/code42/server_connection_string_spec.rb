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
