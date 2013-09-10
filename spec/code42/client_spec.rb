require 'spec_helper'

describe Code42::Client, :vcr do
  subject(:client) do
    Code42::Client.new(
      host: '10.10.46.137',
      port: 4280,
      https: false,
      api_root: '/api',
      username: 'admin',
      password: 'admin',
      verify_https: false,
      debug: true
    )
  end

  describe '#product_licenses' do
    it 'returns an array of product licenses' do
      client.product_licenses.should be_an(Array)
      client.product_licenses.first.should be_a(Code42::ProductLicense)
    end
  end

  describe '#add_product_license' do
    it 'adds a product license' do
      product_licenses = client.add_product_license("ZP5Pbz8wx1dBHKjhkkQjGDZ+tTtkvuD5e5d2TC9/uHoODR9NvyaHfbypRUHR15hbeHdf7ExfnVpmwPiIcgYxCQ==")
      product_licenses.first.license_key.should == "ZP5Pbz8wx1dBHKjhkkQjGDZ+tTtkvuD5e5d2TC9/uHoODR9NvyaHfbypRUHR15hbeHdf7ExfnVpmwPiIcgYxCQ=="
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

  describe "#get_token" do
    it "returns valid tokens" do
      auth = client.get_token
      auth.cookie_token.should have(26).characters
      auth.url_token.should have(26).characters
    end

    context "when providing invalid credentials" do
      it "should raise an exception" do
        client.settings.password = 'badpassword'
        expect{client.get_token}.to raise_error Code42::Error::AuthenticationError
      end
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
      user.org_id.should eq 2
    end

    context "when sending an invalid email" do
      it "raises an exception" do
        user_attributes[:email] = 'testuser'
        expect { client.create_user(user_attributes) }.to raise_error Code42::Error::EmailInvalid
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
        client.user(user_id, :incAll => true)
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
        client.org(2, :incAll => true)
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
end
