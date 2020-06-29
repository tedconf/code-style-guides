# Updating an application to use the gem

1. add this to a project's Gemfile

```
gem 'ted_rubocop_rules'
```

Also remove `gem 'rubocop'` from your Gemfile, and let ted_rubocop_rules decide
what version of rubocop is needed.

2. Remove a locally-cached copy of our rule set which was downloaded via
HTTP. `rm .rubocop-http*`

3. `bundle update --conservative rubocop` to make sure you have the version of
rubocop required our gem.

4. Update your `.rubocop.yml`.

```yaml
AllCops:
  TargetRubyVersion: 2.5 # adjust for your project

inherit_gem:
  ted_rubocop_rules: rubocop.yml

inherit_from: .rubocop_todo.yml # if you have one
```

5. Regenerate your todo list by running `bundle exec rubocop --auto-gen-config`

6. Fix any other warnings that you see the rubocop output. (For example: local
style exceptions which reference rule names which no longer exist in the current
version of rubocop.)

7. Commit & push the results.
