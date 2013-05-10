require 'spec_helper'

describe Code42::Role do
  describe "#deserialize_and_initialize" do
    let(:response_data) do
    data = <<-JSON
      {
        "roleId": 3,
        "roleName": "PROe User",
        "locked": true,
        "creationDate": "2013-01-31T15:51:07.810-06:00",
        "modificationDate": "2013-01-31T15:51:07.810-06:00",
        "permissions":
        [
          {"permission": "admin.cpp.login"},
          {"permission": "admin.console.login"}
        ]
      }
    JSON
    JSON.parse(data)
    end

    it "should translate roleId to id" do
      role = Code42::Role.deserialize_and_initialize(response_data)
      role.id.should eq 3
    end
  end
end
