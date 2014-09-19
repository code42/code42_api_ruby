describe Code42::Client, :vcr do

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

  describe '#server_connection_string' do
    it 'returns a connection string' do
      connection_string = client.server_connection_string(3)
      connection_string.should be_a(Code42::ServerConnectionString)
      connection_string.server_id.should == 3
    end
  end

  describe '#org_share_destinations' do
    it 'returns a provider key' do
      client.org_share_destinations(5).should == 'rO0ABXQCnSI2MDA3ODIyNTE5MDIzNzAwNDkifHwiNjAwNzgyMTgzNjg2MjA5NzkzInx8IkNyYXNoUGxhbiBQUk9lIFNlcnZlciJ8fCJ1cms4Mm1tMjRtdzc4amNjInx8IjEwLjEwLjQ2LjEzNzo0MjgyInx8Im51bGwifHwiMTAuMTAuNDYuMTM3OjQyODYifHwiMTAuMTAuNDYuMTM3OjQyODMifHwiaHR0cDovLzEwLjEwLjQ2LjEzNzo0MjgwInx8Ik1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBb2hoeXdmYUpTWDh2RzZmK2JvR3ZDeGJPUzJrdk8yRlRIQUdJUGJtb0kwUUphd2gxZ3ZPQVFUQk5WeHY2Y1k4R1hKckphelI4dUl0UGQ3ZFNHNFNTbFYyR2FsT09WVUJuRitpUGQ2T1E2cDBhaVgvR1JIcjNqaTU2ZVNNNW1yYlUvTmQybGVKMSttV1Z2UkhOQ2ErTXFWbWQ3K3dNYkJvZk5aeGRSbzhZRk1SSVVMVFJEZk1MRFJLbnZUWUgzRk5vMCt6STZkb1RUeHpueXdTWXlqN0hEbkRDbW4yZGs4WnJwbnNpRkZHU3NDRUxPWXUraDZEUVppTkhlVDdwNWMzYnhSSW1tU2VxOUtPRmxkSlhZYk9ZSXB4TVE0QUtnYXYyWk9RWlBKZkIxOTJNek8rK25TY1B4Z1R6SVR4Nmw1N0xIY3Fzc1RPaFV3Z29JSm9ncTJDZzl3SURBUUFCInx8IlBST1ZJREVSInx8Ijgya21yOGo5a3Bjdzk5cHMifHwiNjAwNzgyMjUyMDE5ODEwNTYxInx8IkNyYXNoUGxhbiBQUk9lIFNlcnZlciJ8fCJudWxsIg=='
    end
  end

  describe '#server_settings' do
    it 'returns a server settings object' do
      client.server_settings(1).should be_a(Code42::ServerSettings)
    end
  end

  describe '#server' do
    it 'returns a server' do
      server = client.server(3)
      server.should be_a(Code42::Server)
      server.id.should == 3
    end
  end

  describe '#update_server_settings' do
    it 'updates server settings' do
      client.update_server_settings(1, name: 'Foo Bar Server')
      client.server_settings(1).name.should == 'Foo Bar Server'
    end
  end

  describe '#destinations' do
    it 'returns an array of desinations' do
      destinations = client.destinations
      destinations.should be_an(Array)
      destinations.first.should be_a(Code42::Destination)
    end
  end

  describe '#create_destination' do
    it 'creates a destination' do
      destination = client.create_destination(provider: true, destination_name: 'aaa', provider_key: 'rO0ABXQCnSI2MDA3ODIyNTE5MDIzNzAwNDkifHwiNjAwNzgyMTgzNjg2MjA5NzkzInx8IkNyYXNoUGxhbiBQUk9lIFNlcnZlciJ8fCJ1cms4Mm1tMjRtdzc4amNjInx8IjEwLjEwLjQ2LjEzNzo0MjgyInx8Im51bGwifHwiMTAuMTAuNDYuMTM3OjQyODYifHwiMTAuMTAuNDYuMTM3OjQyODMifHwiaHR0cDovLzEwLjEwLjQ2LjEzNzo0MjgwInx8Ik1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBb2hoeXdmYUpTWDh2RzZmK2JvR3ZDeGJPUzJrdk8yRlRIQUdJUGJtb0kwUUphd2gxZ3ZPQVFUQk5WeHY2Y1k4R1hKckphelI4dUl0UGQ3ZFNHNFNTbFYyR2FsT09WVUJuRitpUGQ2T1E2cDBhaVgvR1JIcjNqaTU2ZVNNNW1yYlUvTmQybGVKMSttV1Z2UkhOQ2ErTXFWbWQ3K3dNYkJvZk5aeGRSbzhZRk1SSVVMVFJEZk1MRFJLbnZUWUgzRk5vMCt6STZkb1RUeHpueXdTWXlqN0hEbkRDbW4yZGs4WnJwbnNpRkZHU3NDRUxPWXUraDZEUVppTkhlVDdwNWMzYnhSSW1tU2VxOUtPRmxkSlhZYk9ZSXB4TVE0QUtnYXYyWk9RWlBKZkIxOTJNek8rK25TY1B4Z1R6SVR4Nmw1N0xIY3Fzc1RPaFV3Z29JSm9ncTJDZzl3SURBUUFCInx8IlBST1ZJREVSInx8IjRtOWhqNDJrd3BwY21yc20ifHwiNjAwNzgyMjUyMDE5ODEwNTYxInx8IkNyYXNoUGxhbiBQUk9lIFNlcnZlciJ8fCJudWxsIg==')
      destination.should be_true
    end
  end

  describe '#servers' do
    it 'returns an array of servers' do
      client.servers.should be_an(Array)
    end
  end

  describe '#create_server' do
    it 'creates a server' do
      server = client.create_server(connection_string: 'rO0ABXQCmCI2MDA2MjQyNjI0MDI4MDE5MjEifHwiNjAwNjI0MTc0ODU5Mjg4ODMzInx8Im1vcmUtMDIifHwibWh3aGNza3I4bThocHcycyJ8fCIxMC4xMC40Ni45NDo0MjgyInx8Im51bGwifHwiMTAuMTAuNDYuOTQ6NDI4NiJ8fCIxMC4xMC40Ni45NDo0MjgzInx8Imh0dHA6Ly8xMC4xMC40Ni45NDo0MjgwInx8Ik1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBcFcxTVd0bnUyWEd0aXkzQjFWMXJlV1dXR204ak5OV3V1SHVDTGVNcHdqRGVHMUFUQm5aaTV5aEIxSTBBREhCekZYYkwrbHgvTTBMUDJuQkplek9nRVRXQ0R5ZCtncXV1K3pBdlF4K3RrdTZHcmo2cDZhaHgxYnQ2Y0tZd28zcW9jaTMxY3pZOElRWll5V0JVZUducDlEOTd3ZWxmaGgxakkwdEE3MlBUSEt0NzAvcUdDeXZaaVRqK3VSRDhIVTJsL3hDaVh2a2F6Wmc0dzBBQXhmL0VwNUlmNFJBYlNPTzZrTzNjVkFmcWxxcjdxS2dqc04ydGFhVlgvbXM0YnBmQ05ubXhHZWI3bnI1WXMrcUpuT0Q3bytTb1R5dmVJWm5SMUtkeEkwcDBIdmpLd3JSeEpIamdrS0Z6RU1lTFFhVmJlRmhrTm5RM3laVlVydkdOeDZXSHN3SURBUUFCInx8IlNUT1JBR0VfTk9ERSJ8fCJEZWZhdWx0Inx8Ii92YXIvb3B0L3Byb3NlcnZlci9iYWNrdXBBcmNoaXZlcyJ8fCJDcmFzaFBsYW5BcmNoaXZlX0RlZmF1bHQifHwibnVsbCI=', destination_id: 4)
      server.should be_a(Code42::Server)

    end
  end

  describe '#destination' do
    it 'returns a destination' do
      client.destination(45).should be_a(Code42::Destination)
    end
  end

  describe '#product_licenses' do
    it 'returns an array of product licenses' do
      client.product_licenses.should be_an(Array)
      client.product_licenses.first.should be_a(Code42::ProductLicense)
    end
  end

  describe '#add_product_license' do
    it 'adds a product license' do
      product_licenses = client.add_product_license('ZP5Pbz8wx1dBHKjhkkQjGDZ+tTtkvuD5e5d2TC9/uHoODR9NvyaHfbypRUHR15hbeHdf7ExfnVpmwPiIcgYxCQ==')
      product_licenses.first.license_key.should == 'ZP5Pbz8wx1dBHKjhkkQjGDZ+tTtkvuD5e5d2TC9/uHoODR9NvyaHfbypRUHR15hbeHdf7ExfnVpmwPiIcgYxCQ=='
    end
  end

  describe '#remove_product_license' do
    it 'removes a product license' do
      product_licenses = client.product_licenses
      id = product_licenses.first.id
      client.remove_product_license id
      client.product_licenses.should be_empty
    end
  end

  describe '#apply_mlk' do
    it 'applies the mlk' do
      response = client.apply_mlk 'BdYS3i2U+1J/d/sU+IeZ/sTP0mac3k3FyXHxL69MPps3JOUIjb6PUc2UUw5jrD01CnLsJLhnanwJUTCRyjtwn+b7BkI/5kjosUo5RETbLKlc4PToufLu6cELvTUdwi/tMdLJFtx51jtoVdnZu4CfkBbcgcXR9yafkKas8XuOSd0=', {}
      expect(response).to be_a Code42::Token
      expect(response.cookie_token).to eql '1ix3k2701jn5l0kixl1xa05giw'
      expect(response.url_token).to eql '136jc2w1tym050fdkky855t7en'
      client.connection.mlk.should eql 'BdYS3i2U+1J/d/sU+IeZ/sTP0mac3k3FyXHxL69MPps3JOUIjb6PUc2UUw5jrD01CnLsJLhnanwJUTCRyjtwn+b7BkI/5kjosUo5RETbLKlc4PToufLu6cELvTUdwi/tMdLJFtx51jtoVdnZu4CfkBbcgcXR9yafkKas8XuOSd0='
    end
  end

  describe '#validate_token' do
    it 'returns a valid response' do
      token = client.get_token
      validation = client.validate_token token
      validation.should be_valid
    end
  end

  describe '#user_roles' do
    it 'returns an enumerable' do
      roles = client.user_roles
      roles.should respond_to(:each)
    end
  end

  describe '#unassign_role' do

    let(:user_id) { 4 }
    let(:role_name) { 'PROe User' }

    it 'removes the role' do
      current_roles = client.user_roles user_id
      current_role_names = current_roles.map(&:name)

      expect(current_role_names.include? role_name).to be_true

      client.unassign_role(user_id, role_name)
      expect(client.last_response.status).to eq 204

      actual_roles = client.user_roles user_id
      expect(actual_roles).to be_empty
    end
  end

  describe '#permissions' do
    it 'returns an enumerable of permissions' do
      permissions = client.permissions
      permissions.should respond_to(:each)
      expect(permissions.first).to be_a Code42::Permission
    end
  end

  describe '#roles' do
    it 'returns an enumerable' do
      roles = client.roles
      roles.should respond_to(:each)
    end
  end

  describe '#create_role' do
    it 'creates a role' do
      role = client.create_role('My Role', ['admin.user.read'])
      role.name.should == 'My Role'
    end
  end

  describe '#delete_role' do
    it 'deletes a role' do
      client.delete_role(62)
    end
  end

  describe '#update_role' do
    it 'updates a role' do
      role = client.update_role(63, name: 'New name')
      role.name.should == 'New name'
    end
  end

  describe '#get_token' do
    it 'returns valid tokens' do
      auth = client.get_token
      auth.cookie_token.should have(26).characters
      auth.url_token.should have(26).characters
    end

    context 'when providing invalid credentials' do
      it 'should raise an exception' do
        client.settings.password = 'badpassword'
        expect{client.get_token}.to raise_error Code42::Error::AuthenticationError
      end
    end
  end

  describe '#deactivate_org' do
    it 'puts to the correct route' do
      expect(client).to receive(:deactivate_org).with(88).and_call_original
      expect(client).to receive(:put).with('OrgDeactivation/88', {}).and_call_original
      client.deactivate_org(88)
    end
  end

  describe '#create_org' do
    let(:org_attributes) do
      {
        :orgName => 'IBM'
      }
    end

    it 'returns created org' do
      org = client.create_org(org_attributes)
      org.name.should eq 'IBM'
    end
  end

  describe '#create_user' do
    let(:user_attributes) do
      {
        :orgId => 2,
        :username => 'testuser'
      }
    end

    it 'returns created user' do
      user = client.create_user(user_attributes)
      user.username.should eq 'testuser'
      user.id.should eq 38
      user.org_id.should eq 2
    end

    context 'when sending an invalid email' do
      it 'raises an exception' do
        user_attributes[:email] = 'testuser'
        expect { client.create_user(user_attributes) }.to raise_error Code42::Error::EmailInvalid
      end
    end
  end

  describe '#update_user' do
    let(:user_attributes) do
      {
        :orgId => 2,
        :username => 'testuser'
      }
    end

    let(:user) { @user }

    before :each do
      @user = client.create_user(user_attributes)
    end

    it 'returns the updated user' do
      updated_user = client.update_user(user.id, last_name: 'Jenkins')
      expect(updated_user.last_name).to eq 'Jenkins'
    end

    context 'when sending an invalid email' do
      it 'raises an exception' do
        expect{ client.update_user(user.id, email: 'Jenkins') }.to raise_error(Code42::Error::EmailInvalid)
      end
    end
  end

  describe '#user' do
    let(:user_id) { 2 }

    context 'when ID is not passed' do
      it 'returns my user' do
        user = client.user
        user.id.should == 1
      end
    end

    context 'when ID is passed in' do
      it 'returns a specific user' do
        user = client.user(user_id)
        user.id.should == user_id
      end

      it 'passes params to code42 server' do
        client.should_receive(:object_from_response).with(Code42::User, :get, "user/#{user_id}", :incAll => true)
        client.user(user_id, :incAll => true)
      end
    end

    context 'when blocked' do
      it 'returns the blocked status' do
        client.block_user(user_id)
        user = client.user(user_id)
        user.blocked.should be_true
      end
    end

    context 'when unblocked' do
      before(:each) do
        client.block_user(user_id)
      end

      it 'returns the blocked status' do
        client.unblock_user(user_id)
        user = client.user(user_id)
        user.blocked.should be_false
      end
    end
  end

  describe '#org' do
    context 'when ID is not passed' do
      it 'returns my org' do
        org = client.org
        org.id.should == 1
      end
    end

    context 'when ID is passed in' do
      it 'returns a specific org' do
        org = client.org(1)
        org.id.should == 1
      end

      it 'passes params to code42 server' do
        client.should_receive(:object_from_response).with(Code42::Org, :get, 'org/2', :incAll => true)
        client.org(2, :incAll => true)
      end
    end
  end

  describe '#find_org_by_name' do
    it 'returns the org with the specified name' do
      org = client.find_org_by_name 'PROServer Demo'
      org.name.should == 'PROServer Demo'
    end
  end

  describe '#ping' do
    it 'returns a ping' do
      client.ping.should be_true
    end
  end

  describe '#reset_password' do
    shared_examples 'reset_password' do
      it 'is successful' do
        expect(client.reset_password(*arguments)).to be_true
      end
    end

    context 'when sending a username' do
      let(:arguments){ ['admin'] }

      it_behaves_like 'reset_password'
    end

    context 'when sending a view_url' do
      let(:arguments){ %w(admin /new-pw-reset.html) }

      before do
        params = {
          username: 'admin',
          viewUrl: '/new-pw-reset.html'
        }
        client.should_receive(:post).with('UserPasswordReset', params).and_call_original
      end

      it_behaves_like 'reset_password'
    end

    context 'when sending a user_id' do
      context 'as an integer' do
        let(:arguments){ [42] }

        it_behaves_like 'reset_password'
      end

      context 'as a string' do
        let(:arguments){ ['42'] }

        it_behaves_like 'reset_password'
      end
    end
  end
end
