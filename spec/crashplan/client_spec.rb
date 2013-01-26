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

  describe "#user" do
    it "should make request to correct url" do
      client.should_receive(:get).with('/user/my')
      client.user
    end

    it "should return my user" do
      client.user.should == "my user"
    end
  end

  describe "#org" do
    it "should make request to correct path" do
      client.should_receive(:get).with('/org/my')
      client.org
    end

    it "should return my org" do
      client.org.should == "my org"
    end
  end
end
