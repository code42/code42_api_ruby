require 'spec_helper'

describe Crashplan::Client do
  subject(:client) do
    Crashplan::Client.new(
      host: 'example.com',
      port: 1234,
      https: false,
      api_root: '/api/v2'
    )
  end

  it "should accept configuration options as parameters to new" do
    client.settings.should == {
      host:  'example.com',
      port:  1234,
      https: false,
      api_root: '/api/v2'
    }
  end

  describe "#https" do
    it "should return https boolean" do
      client.https.should == false
    end

    it "should default to false" do
      client = Crashplan::Client.new
      client.https.should == false
    end

    it "should set the https boolean" do
      client.https = true
      client.https.should == true
    end
  end

  describe "#api_root" do
    it "should return api root" do
      client.api_root == '/api/v2'
    end

    it "should set the api root" do
      client.api_root = '/api/v3'
      client.api_root.should == '/api/v3'
    end

    it "should default to /api" do
      client = Crashplan::Client.new
      client.api_root.should == '/api'
    end
  end

  describe "#settings" do
    it "should return a hash of client settings" do
      client.settings.should == {
        host:  'example.com',
        port:  1234,
        https: false,
        api_root: '/api/v2'
      }
    end
  end

  describe "#host" do
    it "should return configured host" do
      client.host.should == "example.com"
    end

    it "should set the host" do
      client.host = 'somewhere.com'
      client.host.should == 'somewhere.com'
    end
  end

  describe "#port" do
    it "should return configured port" do
      client.port.should == 1234
    end

    it "should set the port" do
      client.port = 999
      client.port.should == 999
    end
  end

  describe "#user" do
    it "should make request to correct url" do
      client.should_receive(:get).with('/api/user/my')
      client.user
    end

    it "should return my user" do
      client.user.should == "my user"
    end

    it "should throw an error when missing host" do
      client.host = nil
      expect { client.user }.to raise_error
    end

    it "should throw an error when missing port" do
      client.port = nil
      expect { client.user }.to raise_error
    end
  end

  describe "#org" do
    it "should make request to correct path" do
      client.should_receive(:get).with('/api/org/my')
      client.org
    end

    it "should return my org" do
      client.org.should == "my org"
    end

    it "should throw an error when missing host" do
      client.host = nil
      expect { client.org }.to raise_error
    end

    it "should throw an error when missing port" do
      client.port = nil
      expect { client.org }.to raise_error
    end
  end
end
