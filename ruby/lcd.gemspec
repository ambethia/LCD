# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lcd/version'

Gem::Specification.new do |spec|
  spec.name          = "lcd"
  spec.version       = Lcd::VERSION
  spec.authors       = ["Jason L Perry"]
  spec.email         = ["jasper@ambethia.com"]
  spec.summary       = %q{Coder Night, July 2013}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "guard-minitest"
end
