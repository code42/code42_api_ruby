#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'optparse'
require 'highline/import'
require 'crashplan'

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
        opts.banner = "Usage: diagnostic [options] [user@]address[:port]"
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

begin
options = Parser.parse ARGV
rescue ArgumentError
  abort Parser.help
end

if !options[:user]
  options[:user] = ask('Enter username: ')
end

if !options[:password]
  options[:password] = ask('Enter password: ') { |q| q.echo = "*" }
end

client = Crashplan::Client.new(
  :host => options[:host],
  :username => options[:user],
  :password => options[:password],
  :https => options[:ssl],
  :port => options[:port],
  :api_root => '/api'
)

diagnostic = client.diagnostic
jj diagnostic.serialize
