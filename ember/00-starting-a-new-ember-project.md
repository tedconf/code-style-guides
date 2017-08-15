# Starting a new TED Ember project

## 1. git repo

Ember apps should live in their own repo, named the same as the project who's API they consume with `-frontend` appeneded. You don't need to initialize with a readme, we'll let EmberCLI generate that.

eg. Ember app that consume's `cool-project`'s API, should be called `cool-project-frontend

File all github issues on the parent repo (`cool-project`)'s issue tracker. You can reference them in your commits with `tedonf/cool-project#123`

## 2. `ember new`

Update your local installation of `ember-cli` to the [latest version](https://github.com/ember-cli/ember-cli/releases) before doing this.

```
ember new cool-project-frontend
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

* `ember install ember-cli-sass`
* `ember install ember-component-css`

Rename `app/styles/app.css` to `app/styles/app.scss`

Follow the [ember-component-css](https://github.com/ebryn/ember-component-css) usage instructions, being sure to [**disable namespacing**](https://github.com/ebryn/ember-component-css#configuration).

Instead of using the default namespacing, class and style your components with [TED conventional BEM style naming]  (https://github.com/tedconf/code-style-guides/blob/new-ember-app/sass.md#bem-like-naming):


  ```css
  //app/pods/components/my-widget/component.js
  classNames: 'My-widget"

  //app/pods/components/my-widget/styles.scss
  .My-widget {
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

## 7. add TED styles and components

### a) classic style

`ember install ember-cli-ted-bootstrap` for base styles

Add other TED components as needed. All are installable as Ember addons.

Most apps will need these:

* TED style nav bars: [ember-ted-navs](https://github.com/tedconf/ember-ted-navs) 
* TED auth: [ember-ted-session](https://github.com/tedconf/ember-ted-session) 

Depending on the UX, you might also want to install these addons:

UX feature | addon solution 
--- | --- 
modal dialogs | [ember-ted-modals](https://github.com/tedconf/ember-ted-modal) 
select elements | [ember-ted-select](https://github.com/tedconf/ember-ted-select) 
settings drop-down menu | [emnber-ted-gear](https://github.com/tedconf/ember-ted-gear)
fancy pants select menus | [ember-searchable-select](https://github.com/tedconf/ember-searchable-select)
expanding or accordion panels | [ember-collapsible-panel](https://github.com/tedconf/ember-collapsible-panel)

### b) future style!

For new projects, we'll be transitioning off of `ember-cli-ted-bootstrap` and moving towards using a functional css library and components. See [ember-ted-shed](http://tedconf.github.io/ember-ted-select/) for details on how to install in your project and get started with new functional CSS components. 

## 8. setup your testing environment

Install [ember-cli-mirage](https://github.com/samselikoff/ember-cli-mirage) so your tests can use its mock server. This is also helpful for stubbing out API endpoints locally before real API dev is complete.

Install [ember-cli-page-object](http://ember-cli-page-object.js.org/docs/v1.1.x/). Using page objects in your tests reduces duplication and improves test readability. 

## 9. deployment setup

See [deployment setup section](https://github.com/tedconf/code-style-guides/blob/master/ember/03-deployment-setup.md)

## 10. other open source addons we <3

These are all vetted by other TED Ember develoeprs and have been found to be helpful on previous TED Ember projects. Consider installng if the need arises!

what you need? | addon solution
--- | ---
simple logic in HTMLbars | [ember-truth-helpers](https://github.com/jmurphyau/ember-truth-helpers)
form validation | [ember-validations](https://github.com/DockYard/ember-validations)













