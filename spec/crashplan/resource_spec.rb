require 'spec_helper'

module Code42
  describe Resource do
    describe '#serialize' do
      before do
        Resource.class_eval do
          attribute :created_at, :from => 'creationDate', :as => DateTime
          attribute :updated_at, :from => 'modificationDate', :as => DateTime
          attribute :name
          attribute :permissions
        end
      end

      it 'serializes attributes correctly' do
        resource = Resource.new(
          name: 'Test',
          created_at: DateTime.new(2013,1,1),
          updated_at: DateTime.new(2013,1,1),
          permissions: {
            foo_id: 1,
            bar: 2
          }
        )
        serialized = resource.serialize
        serialized.should include('name' => 'Test')
        serialized.should include('creationDate' => '2013-01-01T00:00:00+00:00')
        serialized.should include('modificationDate' => '2013-01-01T00:00:00+00:00')
        serialized.should include('permissions')
        serialized['permissions'].should include('fooId' => 1)
        serialized['permissions'].should include('bar' => 2)
      end
    end

    describe '#deserialize' do
      before do
        class LineItem < Resource
        end
        Resource.class_eval do
          attribute :products, :as => LineItem, :collection => true
        end
      end

      it 'deserialize a single object response with nested objects' do
        attrs =
          {'products' => [
            {'product' => {'name' => 1}},
            {'product' => {'name' => 1}}
          ]}
        res = Resource.new
        deserialized = res.class.deserialize(attrs)
        expect(deserialized[:products].count).to eq 2
      end
    end
  end
end
