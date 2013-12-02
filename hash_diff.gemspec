# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_diff/version'

Gem::Specification.new do |spec|
  spec.name          = "hash_diff"
  spec.version       = HashDiff::VERSION
  spec.authors       = ["acuppy"]
  spec.email         = ["acuppy@gmail.com"]
  spec.description   = %q{Deep Hash comparison}
  spec.summary       = %q{Deep Hash comparison}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6.0"
end
