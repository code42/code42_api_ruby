

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