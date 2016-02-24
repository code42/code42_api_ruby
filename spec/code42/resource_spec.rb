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
