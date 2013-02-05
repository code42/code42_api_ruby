require 'spec_helper'

describe Crashplan::Client do
  subject(:client) do
    Crashplan::Client.new(
      host: 'example.com',
      port: 1234,
      https: false,
      api_root: '/api/v2',
      username: 'admin',
      password: 'admin'
    )
  end

  describe "#auth" do
    it "makes a POST request to /authToken" do
      request = stub_post(%r{/authToken$})
      client.auth
      expect(request).to have_been_made
    end

    it "returns valid tokens" do
      stub_post(%r{/authToken$}).to_return(body: fixture('authToken.json'))
      auth = client.auth
      expect(auth.cookie_token).to eq "0jdeqya6xroz713tn1hxp6d8p1"
      expect(auth.url_token).to eq "1t5839d7lwfxr0g84jf1nqp2vi"
    end

    context "when providing invalid credentials" do
      it "should raise an exception" do
        stub_post(%r{/authToken$}).to_return(body: fixture('auth/bad_password.json'), status: 401)
        client.settings.password = 'badpassword'
        expect{client.auth}.to raise_error Crashplan::Error::AuthenticationError
      end
    end
  end

  describe "#get" do
    it "makes a GET request" do
      path = 'org/my'
      request = stub_get(%r(#{path}$))
      client.get path
      expect(request).to have_been_made
    end
  end
  
  describe "#create_org" do
    let(:org_attributes) do
      {
        :orgName => 'Google'
      }
    end

    it "makes a POST request to /org" do
      request = stub_post(%r{/org$}).to_return(body: fixture('org.my.json'))
      client.create_org(org_attributes)
      expect(request).to have_been_made
    end

    it "returns created org" do
      request = stub_post(%r{/org$}).to_return(body: fixture('org.create.json'))
      org = client.create_org(org_attributes)
      expect(org.name).to eq 'Google'
      expect(org.id).to eq 8
    end

  end

  describe "#create_user" do
    let(:user_attributes) do
      {
        :orgId => 2,
        :username => 'testuser'
      }
    end

    it "makes a POST request to /user" do
      request = stub_post(%r{/user$}).to_return(body: fixture('user.create.json'))
      client.create_user(user_attributes)
      expect(request).to have_been_made
    end

    it "returns created user" do
      stub_post(%r{/user$}).to_return(body: fixture('user.create.json'))
      user = client.create_user(user_attributes)
      expect(user.username).to eq 'testuser'
      expect(user.id).to eq 2
    end
  end

  describe "#user" do
    context "when ID is not passed" do
      it "returns my user" do
        stub_get(%r{/user/my}).to_return(body: fixture('user.my.json'))
        user = client.user
        expect(user.id).to eq 1
      end
    end

    context "when ID is passed in" do
      it "returns a specific user" do
        stub_get(%r{/user/1}).to_return(body: fixture('user.1.json'))
        user = client.user(1)
        expect(user.id).to eq 1
        expect(user.uid).to eq "thwlhuOyiq2svbdcqfmm2demndi"
        expect(user.created_at).to be_a DateTime
      end
    end
  end

  describe "#org" do
    context "when ID is not passed" do
      it "returns my org" do
        stub_get(%r{/org/my}).to_return(body: fixture('org.my.json'))
        org = client.org
        expect(org.id).to eq 1
      end
    end

    context "when ID is passed in" do
      it "returns a specific org" do
        stub_get(%r{/org/1}).to_return(body: fixture("org.1.json"))
        org = client.org(1)
        expect(org.id).to eq 1
      end
    end
  end

  describe "#ping" do
    before do
      stub_get(/example.com/).to_return(body: fixture('ping.json'))
    end

    it "returns a ping" do
      expect(client.ping).to be_a Crashplan::Ping
    end
  end
end
