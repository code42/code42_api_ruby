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
require 'optparse'

class Parser
  class << self
    def options
      @options ||= {}
    end

    def parse(args = [])
      parse_options args
      if args.count < 1 || args[0] =~ /^\d+$/
        raise ArgumentError, 'Invalid arguments'
      end
      options.merge! parse_connection_string(args.shift)
      options[:user_id] = args.shift
      options
    end

    def parse_options(args)
      options[:ssl] = false
      option_parser.parse! args
      options
    end

    def help
      option_parser.help
    end

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: users [options] [user@]address[:port] [user_id]"
        opts.on('-p', '--password [PASSWORD]', String, 'server password') do |password|
          options[:password] = password
        end

        opts.on('--[no-]ssl', 'Use SSL for network communication') do |ssl|
          options[:ssl] = ssl
        end
      end
    end

    def parse_connection_string(connection_string)
      m = connection_string.match /^((?<user>\w+)\@)?(?<host>[\w\.]+)(:(?<port>\d+))?$/
      {
        :user => m[:user],
        :host => m[:host],
        :port => (m[:port].to_i if m[:port])
      }
    end
  end
end
