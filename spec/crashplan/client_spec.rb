require 'spec_helper'

describe Crashplan::Client, :vcr do
  subject(:client) do
    Crashplan::Client.new(
      host: 'localhost',
      port: 7280,
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

  describe "#get_token" do
    it "returns valid tokens" do
      auth = client.get_token
      auth.cookie_token.should have(26).characters
      auth.url_token.should have(26).characters
    end

    context "when providing invalid credentials" do
      it "should raise an exception" do
        client.settings.password = 'badpassword'
        expect{client.get_token}.to raise_error Crashplan::Error::AuthenticationError
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
      user.id.should eq 2
    end

    context "when sending an invalid email" do
      it "raises an exception" do
        user_attributes[:email] = 'testuser'
        expect { client.create_user(user_attributes) }.to raise_error Crashplan::Error::EmailInvalid
      end
    end
  end

  describe "#user" do
    context "when ID is not passed" do
      it "returns my user" do
        user = client.user
        user.id.should == 1
      end
    end

    context "when ID is passed in" do
      it "returns a specific user" do
        user = client.user(2)
        user.id.should == 2
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
    end
  end

  describe "#find_org_by_name" do
    it "returns the org with the specified name" do
      org = client.find_org_by_name 'Default'
      org.name.should == 'Default'
    end
  end

  describe "#ping" do
    it "returns a ping" do
      client.ping.should be_true
    end
  end
end
