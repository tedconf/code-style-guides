require 'yaml'

namespace :lint do
  task :rubocop do
    this_dir = File.dirname(__FILE__)
    YAML.load_file File.join(this_dir, 'linters/rubocop/rubocop.yml')
  end
end

task 'default' => 'lint:rubocop'
