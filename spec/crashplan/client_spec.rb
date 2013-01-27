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

  before do
    Faraday.default_adapter = :net_http
  end

  describe "#get" do
    it "should make a request" do
      stub = stub_request(:get, %r(/org/my$))
      client.get '/org/my'
    end
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
    before do
      stub_request(:any, /example.com/).to_return(body: File.new('spec/fixtures/org.my.json'), status: 200)
    end

    it "should return my org" do
      client.org.should be_a(Crashplan::Org)
    end
  end
end
