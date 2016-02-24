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
