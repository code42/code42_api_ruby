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

  describe "#connection" do
    it "should set host to example.com" do
      client.connection.host.should == 'example.com'
    end

    it "should set port to 1234" do
      client.connection.port.should == 1234
    end

    it "should set authorization headers" do
      client.connection.headers.should have_key('Authorization')
    end

    it "should set scheme to http" do
      client.connection.scheme.should == 'http'
    end

    it "should set api_root to /api/v2" do
      client.connection.path_prefix.should == '/api/v2'
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
  end

  describe "#org" do
    it "should make request to correct path" do
      client.should_receive(:get).with('/api/org/my')
      client.org
    end

    it "should return my org" do
      client.org.should == "my org"
    end
  end
end
