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
  class Settings
    attr_accessor :host, :port, :https, :api_root, :username, :password, :token, :verify_https, :debug, :mlk

    def initialize(options = {})
      options.symbolize_keys!
      self.host     = options[:host]
      self.port     = options[:port]
      self.https    = !options[:https].nil? ? options[:https] : true
      self.verify_https = !options[:verify_https].nil? ? options[:verify_https] : true
      self.api_root = options[:api_root] || '/api'
      self.username = options[:username]
      self.password = options[:password]
      self.token    = options[:token]
      self.debug    = options[:debug]
    end

    def all
      settings = {}
      settings[:host]     = host
      settings[:port]     = port
      settings[:https]    = https
      settings[:api_root] = api_root
      settings[:username] = username
      settings[:password] = password
      settings
    end

    def scheme
      https ? 'https' : 'http'
    end

    def base_url
      raise Error unless valid?
      "#{scheme}://#{host}:#{port}#{api_root}"
    end

    def valid?
      host && port && api_root
    end
  end
end
