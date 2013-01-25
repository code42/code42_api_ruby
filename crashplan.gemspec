# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crashplan/version'

Gem::Specification.new do |gem|
  gem.name          = "crashplan"
  gem.version       = Crashplan::VERSION
  gem.authors       = ["Code 42"]
  gem.email         = ["dev-ruby@code42.com"]
  gem.description   = %q{Provides a Ruby interface to the Crashplan API}
  gem.summary       = %q{...}
  gem.homepage      = ""

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'vcr'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
