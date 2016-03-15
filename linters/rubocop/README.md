## Common configuration for rubocop in TED projects

### Goals

Hold a common base configuration which should apply to all TED ruby projects.
Individual projects may further extend this, but generally the fewer exceptions
we define the better.

### Usage

in your project's .rubocop.yml:

```yml
inherit_from:
  - https://raw.githubusercontent.com/tedconf/code-style-guides/master/ruby/ted-rubocop.yml
  - .rubocop_todo.yml # if you have one
```

The [rubocop README](https://github.com/bbatsov/rubocop#inheriting-configuration-from-a-remote-url)
has more details on how the file is sourced & updated. Essentially, it will be
downloaded to your machine & used. rubocop has some rules about updating the
local copy when the remote file changes. You can also remove your local version
(which will be in a `./rubocop-http*` file) to force an update to the latest.


**NOTE:** Support for sourcing config from URLs was added in [rubocop 0.35.0](https://github.com/bbatsov/rubocop/releases/tag/v0.35.0)
In older versions you'll see `No such file or directory @ rb_sysopen` errors
when starting rubocop.

### Conventions in `rubocop.yml`

  1. Make a branch & open a PR when you want to change something in here.
     Then the git history & closed PRs become documentation about how our
     styles have evolved over time.
  1. Keep configs in alphabetical order by cop name.
  1. Include comments explaining *why* a particular configuration is here.
     Hopefully we'll automate the building of a style guide from these
     someday, so write with that in mind.
  1. Use 3 blank links between blocks of configuration for readability.
