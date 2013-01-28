require 'spec_helper'

describe Crashplan::Ping do
	let(:valid_attributes) do
    { "success" => true }
  end

	subject(:ping) do
    Crashplan::Ping.new(valid_attributes)
  end

  it { should be_success }

end
