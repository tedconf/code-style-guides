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

In `config/environment.js`, add ` podModulePrefix: 'cool-project-frontend/pods' to the `ENV` object.

In `.ember-cli`, add `"usePods": true"` to your config object to ensure your EmberCLI generators create new files within the pods directory.

Create a new application route with the pods structure:

`ember g route application`  (pro tip: `g` is shorthand for `generate`)

Delete the old directories we no longer need:

* `app/controllers`
* `app/components`
* `app/routes`
* `app/templates`


## 5. JS linting

Follow the [Ember Suave](https://github.com/DockYard/ember-suave) installation instructions for JS style linting.

## 6. enable scss & component-css

`ember install ember-cli-sass`

Rename `app/styles/app.css` to `app/styles/app.scss`

To keep your .scss files within the same directories as the components they style, install `ember-component-css`:

* `npm install --save-dev samselikoff/ember-component-css#c81eae1333b057863cea0aea67495e588de7bf28`
* `@import "pod-styles";` in `app/styles/app.scss`
* you can now create `styles.scss` files within component directories and they'll be automatically compiled to app.css
* style component sub-elements and states using [BEM style naming]  (https://github.com/tedconf/code-style-guides/blob/new-ember-app/sass.md#bem-like-naming) 

  ```
  //app/pods/components/my-widget/styles.scss
  .my-widget {
    // widget styles here
    
    &__element {
     // widget element styles
    }
    
    &--modifier {
      // widget modifier styles
    }
  }
  ```
  
Note: your build may fail if you don't have any component styles to import yet!
  
[TOOD: can we get component-css to capitalize the class name to be consistent with TED BEM style?]


## 7. add TED styles and components






