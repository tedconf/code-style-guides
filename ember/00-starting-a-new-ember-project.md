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
* class and style your components with [TED conventional BEM style naming]  (https://github.com/tedconf/code-style-guides/blob/new-ember-app/sass.md#bem-like-naming) 


  ```
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

## 8. setup your testing environment

Follow the install instructions and guides for [ember-cli-mirage](https://github.com/samselikoff/ember-cli-mirage) to set up a mock server. This is also helpful for stubbing out API endpoints locally before real API dev is complete.

Install [ember-cli-page-object](http://ember-cli-page-object.js.org/docs/v1.1.x/). Using page objects in your tets reduced duplication and improve legibility. 

## 9. deployment setup

For Ember apps that will be hosted by a rails app (this is most TED apps), use front_end_builds to manage deploys

If this is the first TED Ember app you've deployed, you'll need to set up an SSH key for front_end_builds, get access keys and the bucket name for AWS, and set up an environment variables for all these before proceeding. Talk to a friendly [frontender](https://github.com/orgs/tedconf/teams/frontenders) to get set up. 

* ensure the Rails app has [front_end_builds](https://github.com/tedconf/front_end_builds) setup
* the dashboard is typically accessible from `https://cool-project.ted.com/frontends` and `https://master.cool-project-staging.ted.com/frontends` for prod and staging, respectively
* for both prod and staging, create a new app in the dashboard with the same name as your project (i.e. `cool-project`) if it's not there already and add your FEB public key
* in your Ember app, install [ember-cli-deploy-front-end-builds-pack] (https://github.com/tedconf/ember-cli-deploy-front-end-builds-pack),
* configure your app name, staging, and prod urls in `config/deploy.js`
  ```
  var app = 'cool-project';
  var stagingHost = 'https://cool-project.ted.com/';
  var productionHost = 'https://master.cool-project-staging.ted.com/';
  ```

* enable asset fingerprinting in `ember-cli-build.js`. Adjust the project name in the prepend string and file extensions as needed. 

  ```
  var isProdOrStaging = (env === 'production') || (env === 'staging');
  
  var app = new EmberApp(defaults, {
    fingerprint: {
      enabled: isProdOrStaging,
      prepend: 'https://frontend-assets.tedcdn.com/cool-project/',
      extensions: ['js', 'css', 'png', 'jpg', 'otf'],
    }
  });
  ```
  
You should now be able to deploy front-end code to staging with `ember deploy staging` and production with `ember deploy production`.

## 10. other open source addons we <3

These are all vetted by other TED Ember develoeprs and have been found to be helpful on previous TED Ember projects. Consider installng if the need arises!

what you need? | addon solution
--- | ---
simple logic in HTMLbars | [ember-truth-helpers](https://github.com/jmurphyau/ember-truth-helpers)
form validation | [ember-validations](https://github.com/DockYard/ember-validations)













