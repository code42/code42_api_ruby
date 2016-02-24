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
describe Code42::Connection do
  subject(:connection) do
    Code42::Connection.new(
      host: 'example.com',
      port: 1234,
      scheme: 'http',
      username: 'fred',
      password: 'letmein',
      path_prefix: '/api/v2'
    )
  end

  describe '#token' do
    it 'sets authorization headers' do
      connection.token = '0jdeqya6xroz713tn1hxp6d8p1-1t5839d7lwfxr0g84jf1nqp2vi'
      expect(connection.headers['Authorization']).to eq 'TOKEN 0jdeqya6xroz713tn1hxp6d8p1-1t5839d7lwfxr0g84jf1nqp2vi'
    end
  end

  it 'should set host to example.com' do
    expect(connection.host).to eq 'example.com'
  end

  it 'should set port to 1234' do
    expect(connection.port).to eq 1234
  end

  it 'should set scheme to http' do
    expect(connection.scheme).to eq 'http'
  end

  it 'should set api_root to /api/v2' do
    expect(connection.path_prefix).to eq '/api/v2'
  end

  it 'should set username to fred' do
    expect(connection.username).to eq 'fred'
  end

  it 'should set password to letmein' do
    expect(connection.password).to eq 'letmein'
  end
end
