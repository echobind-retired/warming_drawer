# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'warming_drawer/version'

Gem::Specification.new do |gem|
  gem.name          = "warming_drawer"
  gem.version       = WarmingDrawer::VERSION
  gem.authors       = ["Chris Ball"]
  gem.email         = ["chris@echobind.com"]
  gem.description   = %q{Adds a generic worker that hits url's to prewarm caches}
  gem.summary       = %q{Adds a generic worker that hits url's to prewarm caches}
  gem.homepage      = "http://github.com/echobind/warming_drawer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib", "spec"]

  gem.add_dependency 'sidekiq'
  gem.add_dependency 'httpclient'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'webmock'
end
