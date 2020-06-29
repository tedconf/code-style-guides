
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ted_rubocop_rules/version"

Gem::Specification.new do |spec|
  spec.name          = "ted_rubocop_rules"
  spec.version       = TedRubocopRules::VERSION
  spec.authors       = ["Alex Dean"]
  spec.email         = ["github@mostlyalex.com"]

  spec.summary       = %q{TED rubocop rules as a gem.}
  spec.description   = %q{TED rubocop rules as a gem.}
  spec.homepage      = "https://github.com/tedconf/code-style-guides/gem"

  # Specify which files should be added to the gem when it is released.
  spec.files         = ["rubocop.yml", "lib/ted_rubocop_rules/version.rb"]

  spec.add_dependency "rubocop", "= 0.86.0"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
end
