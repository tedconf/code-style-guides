## Common configuration for rubocop in TED projects

The rubocop.yml in this directory is the rubocop rule set shared by TED ruby
projects.

Our preferred method for distributing these rules is via the
[`ted_rubocop_rules` gem](../../gem). See [the gem's README](../../gem/README.md)
for more information.

This directory is the official location for our rubocop rules to preserve
backwards-compatibility for projects which are loading the rule set directly
from raw.githubusercontent.com rather than using the gem.
