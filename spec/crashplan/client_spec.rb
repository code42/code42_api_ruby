require 'spec_helper'

describe Crashplan::Client do
  subject(:client) { Crashplan::Client.new }

  before do
    client.host = 'example.com'
    client.port = 1234
  end

  it "should accept configuration options as parameters to new" do
    client = Crashplan::Client.new(
      host: 'example.com',
      port: 1234
    )
    client.host.should == 'example.com'
    client.port.should == 1234
  end

  it "should return configured host" do
    client.host.should == "example.com"
  end

  it "should return configured port" do
    client.port.should == 1234
  end

  describe "user" do
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
    
  describe "org" do
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
