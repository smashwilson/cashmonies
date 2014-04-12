# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cashmonies/version'

Gem::Specification.new do |spec|
  spec.name          = "cashmonies"
  spec.version       = Cashmonies::VERSION
  spec.authors       = ["Ash Wilson"]
  spec.email         = ["smashwilson@gmail.com"]
  spec.summary       = %q{Track your personal finances in YAML.}
  spec.description   = %q{Track your personal finances in YAML.}
  spec.homepage      = "https://github.com/smashwilson/cashmonies"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
end
