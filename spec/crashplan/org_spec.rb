require 'spec_helper'

describe Crashplan::Org do
  let(:valid_attributes) do
    { "data" =>
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
    }
  end

  subject(:org) do
    Crashplan::Org.from_response(valid_attributes)
  end

  describe "#id" do
    it "returns the correct id" do
      expect(org.id).to eq 123
    end
  end

  describe "#created_at" do
    it "returns a DateTime object" do
      expect(org.created_at).to be_a DateTime
    end

    it "returns the correct date" do
      expect(org.created_at.day).to eq 23
      expect(org.created_at.month).to eq 5
      expect(org.created_at.year).to eq 2006
    end
  end

  describe "#updated_at" do
    it "returns a DateTime object" do
      expect(org.updated_at).to be_a DateTime
    end

    it "returns the correct date" do
      expect(org.updated_at.day).to eq 9
      expect(org.updated_at.month).to eq 3
      expect(org.updated_at.year).to eq 2010
    end
  end
end
