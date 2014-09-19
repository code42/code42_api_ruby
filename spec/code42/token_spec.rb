describe Code42::Token do
  describe '#deserialize' do
    it 'turns json data into ruby data' do
      data = %w(06zavyo44u0bv00dpqvrba2mkh 0a3xef19j13kr0xgtehwba1b3w)
      result = Code42::Token.deserialize(data)
      result[:cookie_token].should == '06zavyo44u0bv00dpqvrba2mkh'
      result[:url_token].should == '0a3xef19j13kr0xgtehwba1b3w'
    end
  end

  describe '#from_string' do
    it 'returns an AuthResource' do
      auth = Code42::Token.from_string '06zavyo44u0bv00dpqvrba2mkh-0a3xef19j13kr0xgtehwba1b3w'
      auth.cookie_token.should == '06zavyo44u0bv00dpqvrba2mkh'
      auth.url_token.should == '0a3xef19j13kr0xgtehwba1b3w'
    end
  end

  describe '#token_string' do
    it 'returns concatenated token string' do
      auth = Code42::Token.new(
        cookie_token: '06zavyo44u0bv00dpqvrba2mkh',
        url_token: '0a3xef19j13kr0xgtehwba1b3w'
      )
      auth.token_string.should == '06zavyo44u0bv00dpqvrba2mkh-0a3xef19j13kr0xgtehwba1b3w'
    end
  end
end
