require 'spec_helper.rb'

describe Code42::StorePoint, :vcr do

  subject(:client) do
    Code42::Client.new(
        host: '10.10.40.57',
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
