require 'spec_helper'

describe Crashplan::Client do
  #before do
  #  subject.host = 'example.com'
  #  subject.port = 1234
  #end
  context "when given valid parameters" do
    it "should return my user" do
      subject.user.should == "my user"
    end
    it "should return my org" do
      subject.org.should == "my org"
    end
  end
  context "when given invalid parameters" do
    it "should do something else"
  end
end
