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
    Crashplan::Org.from_response(valid_attributes)
  end

  describe ".serialize" do
    it "serializes data correctly" do
      data = {
        name: 'Target'
      }
      serialized = Crashplan::Org.serialize(data)
      serialized.should be_a(Hash)
      serialized['orgName'].should eq 'Target'
    end
  end

  describe "#id" do
    it "returns the correct id" do
      org.id.should eq 123
    end
  end

  describe "#created_at" do
    it "returns a DateTime object" do
      org.created_at.should be_a DateTime
    end

    it "returns the correct date" do
      org.created_at.day.should eq 23
      org.created_at.month.should eq 5
      org.created_at.year.should eq 2006
    end
  end

  describe "#updated_at" do
    it "returns a DateTime object" do
      org.updated_at.should be_a DateTime
    end

    it "returns the correct date" do
      org.updated_at.day.should eq 9
      org.updated_at.month.should eq 3
      org.updated_at.year.should eq 2010
    end
  end
end
