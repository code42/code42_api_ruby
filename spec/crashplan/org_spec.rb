require 'spec_helper'

describe Crashplan::Org do
  let(:valid_attributes) do
    {
      "orgId"            => 123,
      "orgUid"           => "ADMIN",
      "orgName"          => "ADMIN",
      "status"           => "Active",
      "active"           => true,
      "blocked"          => false,
      "parentOrgId"      => nil,
      "type"             => "ENTERPRISE",
      "creationDate"     => "2006-05-23T15:11:39.159-05:00",
      "modificationDate" => "2010-03-09T15:06:37.724-06:00"
    }
  end

  subject(:org) do
    Crashplan::Org.new(valid_attributes)
  end

  describe "#created_at" do
    it "should be a DateTime" do
      org.created_at.should be_a(DateTime)
    end

    it "should return correct date" do
      org.created_at.day.should == 23
      org.created_at.month.should == 5
      org.created_at.year.should == 2006
    end
  end

  describe "#updated_at" do
    it "should be a DateTime" do
      org.updated_at.should be_a(DateTime)
    end

    it "should return correct date" do
      org.updated_at.day.should == 23
      org.updated_at.month.should == 5
      org.updated_at.year.should == 2006
    end
  end
end
