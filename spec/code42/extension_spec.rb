require 'spec_helper'

module Code42Extension
  module ClientMethods
    def some_method
    end
  end

  module Resources
    class A < Code42::Resource; end
  end
end

describe 'use_extension' do
  before do
    Code42.use_extension Code42Extension
  end

  it 'includes client methods' do
    Code42::Client.new.should respond_to(:some_method)
  end

  it 'includes resources' do
    Code42::A.should == Code42Extension::Resources::A
  end
end
