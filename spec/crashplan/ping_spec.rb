require 'spec_helper'

describe Code42::Ping do
	let(:valid_attributes) do
    { "success" => true }
  end

	subject(:ping) do
    Code42::Ping.new(valid_attributes)
  end

  it { should be_success }

end
