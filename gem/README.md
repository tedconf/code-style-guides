## Common configuration for rubocop in TED projects

See the [Using Rubocop](../doc/guides/using_rubocop.html.md) tech guide for
more details on how this configuration fits into our overall rubocop implementation.

## Goals

Hold a common base configuration which should apply to all TED ruby projects.
Individual projects may further extend this, but generally the fewer exceptions
we define the better.

## Usage

in your `Gemfile`

```ruby
group :development, :test do
  gem 'ted_rubocop_rules'
end
```

in your `.rubocop.yml`:

```yml
AllCops:
  TargetRubyVersion: 2.5 # adjust for your project

inherit_gem:
  ted_rubocop_rules: rubocop.yml

inherit_from: .rubocop_todo.yml # if you have one
```

See [the rubocop docs on 'Inheriting configuration from a dependency gem'](https://docs.rubocop.org/rubocop/configuration.html#inheriting-configuration-from-a-dependency-gem)
for more information on how this works.

## Conventions in `rubocop.yml`

  1. Make a branch & open a PR when you want to change something in here.
     Then the git history & closed PRs become documentation about how our
     styles have evolved over time.
  1. Keep configs in alphabetical order by cop name.
  1. Include comments explaining *why* a particular configuration is here.
     Hopefully we'll automate the building of a style guide from these
     someday, so write with that in mind.

## Severities

Every cop we enable should have an explicitly-assigned severity. See
['Understanding violation severities'](https://github.com/tedconf/code-style-guides/blob/master/doc/guides/using_rubocop.html.md#understanding-violation-severities)
for guidance on which to use when proposing a new cop.

## Doing a release

  1. Edit [`../linters/rubocop/rubocop.yml`](../linters/rubocop/rubocop.yml).
  1. Update the CHANGELOG.
  1. Increment [`lib/version.rb`](lib/version.rb).
  1. Push to a branch and open a PR.
  1. Once consensus is reached, merge PR.
  1. `bundle exec rake release`
