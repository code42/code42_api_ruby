require 'spec_helper'

describe Code42::Client, :vcr do

  subject(:client) do
    Code42::Client.new(
      host: 'localhost',
      port: 4280,
      https: false,
      api_root: '/api',
      username: 'admin',
      password: 'admin'
    )
  end

  describe "#validate_token" do
    it "returns a valid response" do
      token = client.get_token
      validation = client.validate_token token
      validation.should be_valid
    end
  end

  describe "#user_roles" do
    it "returns an enumerable" do
      roles = client.user_roles
      roles.should respond_to(:each)
    end
  end

  describe "#unassign_role" do

    let(:user_id) { 4 }
    let(:role_name) { 'PROe User' }

    it "removes the role" do
      current_roles = client.user_roles user_id
      current_role_names = current_roles.map(&:name)

      expect(current_role_names.include? role_name).to be_true

      client.unassign_role(user_id, role_name)
      expect(client.last_response.status).to eq 204

      actual_roles = client.user_roles user_id
      expect(actual_roles).to be_empty
    end
  end

  describe "#permissions" do
    it "returns an enumerable of permissions" do
      permissions = client.permissions
      permissions.should respond_to(:each)
      expect(permissions.first).to be_a Code42::Permission
    end
  end

  describe "#roles" do
    it "returns an enumerable" do
      roles = client.roles
      roles.should respond_to(:each)
    end
  end

  describe "#create_role" do
    it 'creates a role' do
      role = client.create_role('My Role', ['admin.user.read'])
      role.name.should == 'My Role'
    end
  end

  describe "#delete_role" do
    it "deletes a role" do
      client.delete_role(62)
    end
  end

  describe "#update_role" do
    it "updates a role" do
      role = client.update_role(63, name: 'New name')
      role.name.should == 'New name'
    end
  end

  describe "#get_token" do
    it "returns valid tokens" do
      auth = client.get_token
      auth.cookie_token.should have(26).characters
      auth.url_token.should have(26).characters
    end

    context "when providing invalid credentials" do
      it "should raise an exception" do
        client.settings.password = 'badpassword'
        expect{client.get_token}.to raise_error { |error|
          expect(error).to be_a Code42::Error::AuthenticationError
          expect(error.status).to eq 401
          expect(error.response.body.first['description']).to eq "Invalid or missing credentials"
        }
      end
    end
  end

  describe '#deactivate_org' do
    it 'puts to the correct route' do
      expect(client).to receive(:deactivate_org).with(88).and_call_original
      expect(client).to receive(:put).with("OrgDeactivation/88").and_call_original
      client.deactivate_org(88)
    end
  end

  describe "#create_org" do
    let(:org_attributes) do
      {
        :orgName => 'IBM'
      }
    end

    it "returns created org" do
      org = client.create_org(org_attributes)
      org.name.should eq 'IBM'
    end
  end

  describe "#create_user" do
    let(:user_attributes) do
      {
        :orgId => 2,
        :username => 'testuser'
      }
    end

    it "returns created user" do
      user = client.create_user(user_attributes)
      user.username.should eq 'testuser'
      user.id.should eq 38
    end

    context "when sending an invalid email" do
      it "raises an exception" do
        user_attributes[:email] = 'testuser'
        expect { client.create_user(user_attributes) }.to raise_error Code42::Error::EmailInvalid
      end
    end
  end

  describe "#update_user" do
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

    it "returns the updated user" do
      updated_user = client.update_user(user.id, last_name: 'Jenkins')
      expect(updated_user.last_name).to eq 'Jenkins'
    end

    context "when sending an invalid email" do
      it "raises an exception" do
        expect{ client.update_user(user.id, email: 'Jenkins') }.to raise_error(Code42::Error::EmailInvalid)
      end
    end
  end

  describe "#user" do
    let(:user_id) { 2 }

    context "when ID is not passed" do
      it "returns my user" do
        user = client.user
        user.id.should == 1
      end
    end

    context "when ID is passed in" do
      it "returns a specific user" do
        user = client.user(user_id)
        user.id.should == user_id
      end

      it "passes params to code42 server" do
        client.should_receive(:object_from_response).with(Code42::User, :get, "user/#{user_id}", :incAll => true)
        user = client.user(user_id, :incAll => true)
      end
    end

    context "when blocked" do
      it "returns the blocked status" do
        client.block_user(user_id)
        user = client.user(user_id)
        user.blocked.should be_true
      end
    end

    context "when unblocked" do
      before(:each) do
        client.block_user(user_id)
      end

      it "returns the blocked status" do
        client.unblock_user(user_id)
        user = client.user(user_id)
        user.blocked.should be_false
      end
    end
  end

  describe "#org" do
    context "when ID is not passed" do
      it "returns my org" do
        org = client.org
        org.id.should == 1
      end
    end

    context "when ID is passed in" do
      it "returns a specific org" do
        org = client.org(1)
        org.id.should == 1
      end

      it "passes params to code42 server" do
        client.should_receive(:object_from_response).with(Code42::Org, :get, "org/2", :incAll => true)
        user = client.org(2, :incAll => true)
      end
    end
  end

  describe "#find_org_by_name" do
    it "returns the org with the specified name" do
      org = client.find_org_by_name 'PROServer Demo'
      org.name.should == 'PROServer Demo'
    end
  end

  describe "#ping" do
    it "returns a ping" do
      client.ping.should be_true
    end
  end

  describe "#reset_password" do
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
