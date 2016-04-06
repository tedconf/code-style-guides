# Starting a new TED Ember project

## 1. git repo

Ember apps should live in their own repo, named the same as the project who's API they consume with `-frontend` appeneded. You don't need to initialize with a readme, we'll let EmberCLI generate that.

eg. Ember app that consume's `cool-project`'s API, should be called `cool-project-frontend

File all github issues on the parent repo (`cool-project`)'s issue tracker. You can reference them in your commits with `tedonf/cool-project#123`

## 2. `ember init`

Update your local installation of `ember-cli` to the [latest version](https://github.com/ember-cli/ember-cli/releases) before doing this.

```
mkdir cool-project-frontend
cd cool-project-frontend
ember init
```

## 3. `git init`

`git init` to turn your new project into a git repo, then follow github's instructions for linking to your upstream repo. It should look something like:

```
git remote add origin git@github.com:tedconf/cool-project-frontend.git
```

## 4. use pods structure

We prefer the non-default [pods structure](http://ember-cli.com/user-guide/#pod-structure) for TED Ember apps, so you'll have to config your app to use them.

In `enviornment.js`, add ` podModulePrefix: 'cool-project-frontend/pods' to the `ENV` object.

In `.ember-cli`, add `"usePods": true"` to your config object to ensure your EmberCLI generators create new files within the pods directory.




