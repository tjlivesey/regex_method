# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'regex_method/version'

Gem::Specification.new do |spec|
  spec.name          = "regex_method"
  spec.version       = RegexMethod::VERSION
  spec.authors       = ["Tom Livesey"]
  spec.email         = ["tjlivesey@gmail.com"]
  spec.description   = %q{Define methods with a regex.}
  spec.summary       = %q{Define methods with a regex as the method name to avoid implementing method_missing calls}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
