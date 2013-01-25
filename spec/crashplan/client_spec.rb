require 'spec_helper'

describe Crashplan::Client do
  subject(:client) { Crashplan::Client.new }

  before do
    client.host  = 'example.com'
    client.port  = 1234
    client.https = false
  end

  it "should accept configuration options as parameters to new" do
    client = Crashplan::Client.new(
      host:  'somewhere.com',
      port:  24,
      https: false
    )
    client.settings.should == {
      host:  'somewhere.com',
      port:  24,
      https: false
    }
  end

  describe "#https" do
    it "should return https boolean" do
      client.https.should == false
    end

    it "should default to true" do
      client = Crashplan::Client.new
      client.https.should == true
    end
  end

  describe "#settings" do
    it "should return a hash of client settings" do
      client.settings.should == {
        host:  'example.com',
        port:  1234,
        https: false
      }
    end
  end

  describe "#host" do
    it "should return configured host" do
      client.host.should == "example.com"
    end
  end

  describe "#port" do
    it "should return configured port" do
      client.port.should == 1234
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
