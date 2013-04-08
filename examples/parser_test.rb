$:.unshift File.dirname(__FILE__)
require 'bundler/setup'
require 'turn'
require 'minitest/autorun'
require 'parser'

describe Parser do

  describe '.parse_options' do
    it 'parses command line options' do
      options = Parser.parse_options(["--no-ssl", "--password", "letmein"])
      options[:password].must_equal 'letmein'
      options[:ssl].must_equal false
    end
  end

  describe ".parse_connection_string" do
    it 'parses string in form user@host:port' do
      options = Parser.parse_connection_string('user@host:1234')
      options[:user].must_equal 'user'
      options[:host].must_equal 'host'
      options[:port].must_equal 1234
    end

    it 'parses strings in form host:port' do
      options = Parser.parse_connection_string('host:1234')
      options[:user].must_equal nil
      options[:host].must_equal 'host'
      options[:port].must_equal 1234
    end

    it 'parses strings in form user@host' do
      options = Parser.parse_connection_string('user@host')
      options[:user].must_equal 'user'
      options[:host].must_equal 'host'
      options[:port].must_equal nil
    end

    it 'parses strings in form host' do
      options = Parser.parse_connection_string('host')
      options[:user].must_equal nil
      options[:host].must_equal 'host'
      options[:port].must_equal nil
    end
  end

  describe '.parse' do
    it 'parses arguments' do
      options = Parser.parse ['-p', 'letmein', '--no-ssl', 'fred@localhost']
      options[:password].must_equal 'letmein'
      options[:ssl].must_equal false
      options[:user].must_equal 'fred'
      options[:host].must_equal 'localhost'
    end

    it 'raises an error when args is empty' do
      lambda { Parser.parse([]) }.must_raise ArgumentError
    end

    it 'raises an error when first arg is a number' do
      lambda { Parser.parse(['1']) }.must_raise ArgumentError
    end
  end
end
