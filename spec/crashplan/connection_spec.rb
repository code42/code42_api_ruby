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

  it "should set host to example.com" do
    connection.host.should == 'example.com'
  end

  it "should set port to 1234" do
    connection.port.should == 1234
  end

  it "should set scheme to http" do
    connection.scheme.should == 'http'
  end

  it "should set api_root to /api/v2" do
    connection.path_prefix.should == '/api/v2'
  end

  it "should set username to fred" do
    connection.username.should == 'fred'
  end

  it "should set password to letmein" do
    connection.password.should == 'letmein'
  end
end
