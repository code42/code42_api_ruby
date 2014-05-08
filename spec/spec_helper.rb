require 'code42'
require 'active_support'
require 'rspec/autorun'
require 'vcr'
require 'net/http'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { :record => :new_episodes }
  config.configure_rspec_metadata!
end

Code42.configure do |config|
  config.host     = "localhost"
  config.port     = 7280
  config.username = "admin"
  config.password = "admin"
  config.api_root = "/api"
end

def a_get(path)
  a_request(:get, path)
end

def a_post(path)
  a_request(:post, path)
end

def a_delete(path)
  a_request(:delete, path)
end

def a_put(path)
  a_request(:put, path)
end

def stub_get(path)
  stub_request(:get, path)
end

def stub_post(path)
  stub_request(:post, path)
end

def stub_delete(path)
  stub_request(:delete, path)
end

def stub_put(path)
  stub_request(:put, path)
end

def fixture(file)
  File.new("spec/fixtures/#{file}")
end
