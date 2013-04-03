require 'spec_helper'

module Crashplan
  describe Resource do
    describe '#serialize' do
      before do
        Resource.class_eval do
          attribute :created_at, :from => 'creationDate', :as => DateTime
          attribute :updated_at, :from => 'modificationDate', :as => DateTime
          attribute :name
        end
      end
      it 'serializes attributes correctly' do
        resource = Resource.new(name: 'Test', created_at: DateTime.now(), updated_at: DateTime.now())
        resource.serialize.should == {
          name: 'Test',
          created_at: 1
        }
      end
    end
  end
end
