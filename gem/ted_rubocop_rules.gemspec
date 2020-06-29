
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
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", "= 0.86.0"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
end
