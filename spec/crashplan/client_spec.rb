require 'spec_helper'

describe Crashplan::Client do
  before do
    subject.host = 'example.com'
    subject.port = 1234
  end
  context "when given valid parameters" do
    it "should return configured host" do
      subject.host.should == "example.com"
    end
    it "should return configured port" do
      subject.port.should == 1234
    end
  end

  describe "user" do
    it "should return my user" do
      subject.user.should == "my user"
    end
    it "should throw an error when missing host" do
      subject.host = nil
      expect { subject.user }.to raise_error
    end
    it "should throw an error when missing port" do
      subject.port = nil
      expect { subject.user }.to raise_error
    end
  end
    
  describe "org" do
    it "should return my org" do
      subject.org.should == "my org"
    end
    it "should throw an error when missing host" do
      subject.host = nil
      expect { subject.org }.to raise_error
    end
    it "should throw an error when missing port" do
      subject.port = nil
      expect { subject.org }.to raise_error
    end
  end
end
