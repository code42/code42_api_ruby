# Copyright (c) 2016 Code42, Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
describe Code42::Role do
  describe '#deserialize_and_initialize' do
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

    it 'should translate roleId to id' do
      role = Code42::Role.deserialize_and_initialize(response_data)
      role.id.should eq 3
    end
  end
end
