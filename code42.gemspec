# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'code42/version'

Gem::Specification.new do |gem|
  gem.name          = "code42"
  gem.version       = Code42::VERSION
  gem.authors       = ["Code 42"]
  gem.email         = ["dev-ruby@code42.com"]
  gem.description   = %q{Provides a Ruby interface to the Code42 API}
  gem.summary       = %q{...}
  gem.homepage      = "http://www.crashplan.com/apidocviewer/"

  gem.add_development_dependency 'rspec',   '~> 2.14.0'
  gem.add_development_dependency 'webmock', '~> 1.11.0'
  gem.add_development_dependency 'vcr',     '~> 2.5.0'
  gem.add_development_dependency 'rake'

  gem.add_dependency 'faraday',             '~> 0.9.0'
  gem.add_dependency 'activesupport',       '>= 3.2.0'
  gem.add_dependency 'faraday_middleware',  '~> 0.9.1'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
