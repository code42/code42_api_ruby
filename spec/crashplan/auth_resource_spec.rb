require 'spec_helper'

describe Crashplan::AuthResource do
  describe "#deserialize" do
    it "turns json data into ruby data" do
      data = [
        "06zavyo44u0bv00dpqvrba2mkh",
        "0a3xef19j13kr0xgtehwba1b3w"
      ]
      result = Crashplan::AuthResource.deserialize(data)
      expect(result[:cookie_token]).to eq "06zavyo44u0bv00dpqvrba2mkh"
      expect(result[:url_token]).to eq "0a3xef19j13kr0xgtehwba1b3w"
    end
  end

  describe "#token_string" do
    it "returns concatenated token string" do
      auth = Crashplan::AuthResource.new(
        cookie_token: '06zavyo44u0bv00dpqvrba2mkh',
        url_token: '0a3xef19j13kr0xgtehwba1b3w'
      )
      expect(auth.token_string).to eq "06zavyo44u0bv00dpqvrba2mkh-0a3xef19j13kr0xgtehwba1b3w"
    end
  end
end
