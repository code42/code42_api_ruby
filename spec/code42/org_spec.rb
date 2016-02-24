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
describe Code42::Org do
  let(:valid_attributes) do
    {
      'orgId' => 123,
      'orgUid' => 'ADMIN',
      'orgName' => 'ADMIN',
      'status' => 'Active',
      'active' => true,
      'blocked' => false,
      'parentOrgId' => nil,
      'type' => 'ENTERPRISE',
      'creationDate' => '2006-05-23T15:11:39.159-05:00',
      'modificationDate' => '2010-03-09T15:06:37.724-06:00'
    }
  end

  subject(:org) do
    Code42::Org.from_response(valid_attributes)
  end

  describe '.serialize' do
    it 'serializes data correctly' do
      data = {
        name: 'Target'
      }
      serialized = Code42::Org.serialize(data)
      serialized.should be_a(Hash)
      serialized['orgName'].should eq 'Target'
    end
  end

  describe '#id' do
    it 'returns the correct id' do
      org.id.should eq 123
    end
  end

  describe '#created_at' do
    it 'returns a DateTime object' do
      org.created_at.should be_a DateTime
    end

    it 'returns the correct date' do
      org.created_at.day.should eq 23
      org.created_at.month.should eq 5
      org.created_at.year.should eq 2006
    end
  end

  describe '#updated_at' do
    it 'returns a DateTime object' do
      org.updated_at.should be_a DateTime
    end

    it 'returns the correct date' do
      org.updated_at.day.should eq 9
      org.updated_at.month.should eq 3
      org.updated_at.year.should eq 2010
    end
  end
end
