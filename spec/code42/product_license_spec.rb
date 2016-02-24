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


describe Code42::ProductLicense do

  let(:valid_attributes) do
    {
        id: 1234,
        creation_date: DateTime.new,
        expiration_date: DateTime.new,
        product_license: 'asdfasdfasdfasdf'
    }
  end

  subject(:product_license) { Code42::ProductLicense.new valid_attributes }

  let(:client) do
    client = double(Code42::Client)
    allow(client).to receive(:remove_product_license) { 'Product license removed' }
    client
  end

  describe '#id' do
    it 'returns the license id' do
      expect(product_license.id).to eql valid_attributes[:id]
    end
  end

  describe '#remove' do
    it 'removes the product license' do
      allow(product_license).to receive(:client) { client }
      expect(product_license.remove).to eql 'Product license removed'
    end
  end
end
