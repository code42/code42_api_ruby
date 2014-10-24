describe Code42::User do
  let(:valid_attributes) do
    {
      :id => 1,
      :uid => 'thwlhuOyiq2svbdcqfmm2demndi',
      :status => 'Active'
    }
  end

  subject(:user) do
    Code42::User.new(valid_attributes)
  end

  describe '#id' do
    it 'should return correct id' do
      user.id.should == 1
    end
  end
end
