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
