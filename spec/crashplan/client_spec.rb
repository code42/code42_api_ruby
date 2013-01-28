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
      path = 'org/my'
      stub = stub_get(%r(#{path}$))
      client.get path
      stub.should have_been_made
    end
  end

  describe "#user" do
    before do
      stub_get(/example.com/).to_return(body: fixture('user.my.json'))
    end

    it "should return my user" do
      client.user.should be_a(Crashplan::User)
    end
  end

  describe "#org" do
    before do
      stub_get(/example.com/).to_return(body: fixture('org.my.json'))
    end

    it "should return my org" do
      client.org.should be_a(Crashplan::Org)
    end
  end
end
