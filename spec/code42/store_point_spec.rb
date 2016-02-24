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
describe Code42::StorePoint, :vcr do

  subject(:client) do
    Code42::Client.new(
        host: 'localhost',
        port: 4280,
        https: false,
        api_root: '/api',
        username: 'admin',
        password: 'admin',
        verify_https: false,
        debug: true
    )
  end

  let(:valid_attributes) do
    {
      :id => 2,
      :name => '651951667247317249_Default',
      :server_name => 'test_storage_node',
      :destination_name => 'local-storage',
      :org_count => 0,
      :accepting_inbound_backup => true,
      :accepting_inbound_computers => true,
      :balancing_data => true
    }
  end

  describe '#find_store_point_by_id' do
    it 'should return correct store point' do
      client.find_store_point_by_id(valid_attributes[:id]).id.should == 2
    end
  end

  describe '#find_store_point_by_name' do
    it 'should return correct store point' do
      store_points = client.find_store_points_by_name(valid_attributes[:name])
      expect(store_points.first.name).to eql '651951667247317249_Default'
    end
  end

  describe '#find_store_point_by_server_name' do
    it 'should return correct store point' do
      store_points = client.find_store_points_by_name(valid_attributes[:server_name])
      expect(store_points.first.server_name).to eql 'test_storage_node'
    end
  end

  describe '#disable_inbound_backup' do
    it 'should return store point with inbound backup disabled' do
      store_point = client.find_store_point_by_id(valid_attributes[:id]).disable_inbound_backup
      store_point.accepting_inbound_backup.should == false
    end
  end

  describe '#enable_inbound_backup' do
    it 'should return store point with inbound backup disabled' do
      store_point = client.find_store_point_by_id(valid_attributes[:id]).enable_inbound_backup
      store_point.accepting_inbound_backup.should == true
    end
  end

  describe '#disable_balancing' do
    it 'should return store point with balancing enabled' do
      store_point = client.find_store_point_by_id(valid_attributes[:id]).disable_balancing
      store_point.balancing_data.should == false
    end
  end

  describe '#enable_balancing' do
    it 'should return store point with balancing enabled' do
      store_point = client.find_store_point_by_id(valid_attributes[:id]).enable_balancing
      store_point.balancing_data.should == true
    end
  end

  describe '#reject_new_devices' do
    it 'should return store point with accept new devices disabled' do
      store_point = client.find_store_point_by_id(valid_attributes[:id]).reject_new_devices
      store_point.accepting_new_computers.should == false
    end
  end

  describe '#accept_new_devices' do
    it 'should return store point with accept new devices enabled' do
      store_point = client.find_store_point_by_id(valid_attributes[:id]).accept_new_devices
      store_point.accepting_new_computers.should == true
    end
  end
end
