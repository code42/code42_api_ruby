require 'spec_helper'

describe Crashplan::Settings do
  subject(:settings) { Crashplan::Settings.new }

  describe "#host" do
    it "should return configured host" do
      settings.host = "example.com"
      settings.host.should == "example.com"
    end
  end

  describe "#base_url" do
    it "should build base_url properly" do
      settings.https = true
      settings.host = 'example.com'
      settings.port = 123
      settings.api_root = '/api'
      settings.base_url.should eq 'https://example.com:123/api'
    end

    it "should raise an exception if settings invalid" do
      settings.host = 'example.com'
      expect { settings.base_url }.to raise_error(Crashplan::Error)
    end
  end

  describe "#valid?" do
    it "should return true if required properties are defined" do
      settings.host = 'example.com'
      settings.port = 123
      settings.api_root = '/api'
      settings.should be_valid
      settings.should be_valid
    end

    it "should return false if required properties aren't defined" do
      settings.host = 'example.com'
      settings.api_root = '/api'
      settings.should_not be_valid
      settings.should_not be_valid
    end
  end

  describe "#scheme" do
    it "should be http if https is false" do
      settings.https = false
      settings.scheme.should eq 'http'
    end

    it "should be https if https is true" do
      settings.https = true
      settings.scheme.should == 'https'
      settings.scheme.should eq 'https'
    end
  end

  describe "#port" do
    it "should return configured port" do
      settings.port = 123
      settings.port.should eq 123
    end
  end

  describe "#https" do
    it "should return the https boolean" do
      settings.https = true
      settings.https.should be_true
    end

    it "should default to false" do
      settings = Crashplan::Settings.new
      settings.https.should be_false
    end
  end

  describe "#api_root" do
    it "should return the api root" do
      settings.api_root = '/api/v3'
      settings.api_root.should eq '/api/v3'
    end
  end

  describe "#username" do
    it "should return the username" do
      settings.username = 'bob'
      settings.username.should eq 'bob'
    end
  end

  describe "#password" do
    it "should return the password" do
      settings.password = 'bob'
      settings.password.should eq 'bob'
    end
  end

  describe "#all" do
    it "should return a hash of all settings" do
      settings = Crashplan::Settings.new(
        host: 'example.com',
        port: 123,
        api_root: '/api',
        https: true,
        username: 'fred',
        password: 'secret'
      )
      settings.all.should eq({
        host: 'example.com',
        port: 123,
        https: true,
        api_root: '/api',
        username: 'fred',
        password: 'secret'
      })
    end
  end
end
