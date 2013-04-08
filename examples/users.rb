#!/usr/bin/env ruby

require 'rubygems'
require './parser'
require 'bundler/setup'
require 'crashplan'

begin
options = Parser.parse ARGV
rescue ArgumentError
  abort Parser.help
end

client = Crashplan::Client.new(
  :host => options[:host],
  :username => options[:user],
  :password => options[:password],
  :https => options[:ssl],
  :port => options[:port],
  :api_root => '/api'
)

if options[:user_id]
  user = client.user(options[:user_id].to_i, :incAll => true)
  jj user.serialize
else
  users = client.users(:incAll => true)
  jj users.map(&:serialize)
end
