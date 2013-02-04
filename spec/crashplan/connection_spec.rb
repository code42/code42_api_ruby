require 'spec_helper'

describe Crashplan::Connection do
  subject(:connection) do
    Crashplan::Connection.new(
      host: 'example.com',
      port: 1234,
      scheme: 'http',
      username: 'fred',
      password: 'letmein',
      path_prefix: '/api/v2'
    )
  end

  describe "#token" do
    it "sets authorization headers" do
      connection.token = "0jdeqya6xroz713tn1hxp6d8p1-1t5839d7lwfxr0g84jf1nqp2vi"
      expect(connection.headers['Authorization']).to eq "TOKEN 0jdeqya6xroz713tn1hxp6d8p1-1t5839d7lwfxr0g84jf1nqp2vi"
    end
  end

  it "should set host to example.com" do
    expect(connection.host).to eq 'example.com'
  end

  it "should set port to 1234" do
    expect(connection.port).to eq 1234
  end

  it "should set scheme to http" do
    expect(connection.scheme).to eq 'http'
  end

  it "should set api_root to /api/v2" do
    expect(connection.path_prefix).to eq '/api/v2'
  end

  it "should set username to fred" do
    expect(connection.username).to eq 'fred'
  end

  it "should set password to letmein" do
    expect(connection.password).to eq 'letmein'
  end
end
