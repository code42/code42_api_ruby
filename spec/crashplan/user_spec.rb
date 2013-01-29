require 'spec_helper.rb'

describe Crashplan::User do
  let(:valid_attributes) do
    {
      "userId" => 1,
      "userUid" => "thwlhuOyiq2svbdcqfmm2demndi",
      "status" => "Active"
    }
  end

  subject(:user) do
    Crashplan::User.new(valid_attributes)
  end

  describe "#id" do
    it "should return correct id" do
      expect(user.id).to eq 1
    end
  end
end
