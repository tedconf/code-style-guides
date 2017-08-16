# Deployment setup

## Overview

For Ember apps that will be hosted by a Rails app (this is most TED apps), use front_end_builds (FEB) to manage deploys.

FEB consists of 2 components: 

1. a rails gem, [front_end_builds](https://github.com/tedconf/front_end_builds)
2. an ember deploy addon, [ember-cli-deploy-front-end-builds-pack](https://github.com/tedconf/ember-cli-deploy-front-end-builds-pack)

### What happens during a deploy
* Ember app is built into static files (HTML, JS, CSS, other assets) from the current branch and most recent local commit
* Ember app files are uploaded to an S3 bucket
* the Rails app is notified that a new build is available. More specifically, a front_end_builds record is added to the database. This records includes a pointer to the build's index.html file.
* [optional, depending on config] the new build is flagged as "live"

### How the app gets served:
* the Rails server has a front-end app route configured, typically `/`
* any visits to this front-end app route will serve the live Ember build's index.html page
* any visits to a child route of the front-end app route will also serve the Ember app, unless a matching Rails route exists
* all subsequent routing after the initial Ember app load is handled by Ember's router

    Eg. if your `routes.rb` file looks like this: 

    ```rb 
    Rails.application.routes.draw do

      mount FrontEndBuilds::Engine, at: '/frontends'
      front_end 'my-app', '/'

    end
    ```

* visiting `my-app.ted.com/` will serve the Ember app's index route
* visiting `my-app.ted.com/dashboard` will serve the Ember app's `dashboard` route
* visiting `my-app.ted.com/frontends` will serve the front_end_builds admin page in Rails

### Managing deploys via the admin:

The admin page is conventionally located at:

```
your-app.ted.com/frontends
```

If it's not there, check the Rails app's `config/routes.rb` to see where front_end_builds has been mounted.

From here you can:

* mark any build that has been deployed as "Live"
* preview any build without making it live, using the "Launch" feature
* configure whether or not new builds should automatically be made live
* add and remove deploy SSH keys 

Creating new front-end apps can also be done from the admin but will be covered later in this guide. 

## Configuring your app for front_end_builds

### Rails setup

In your Rails app that will be hosting the Ember app,

1. setup the Rails gem, as detailed in the [README](https://github.com/tedconf/front_end_builds/blob/master/README.md) 
2. deploy your updated Rails code

### Admin setup

Once the Rails setup above is complete,

1. visit your admin page (eg. `your-app.ted.com/frontends`) 
2. from the admin, create a new app. The name must match what you've configured in Rails.
2. add your FEB public SSH key to the admin (SSH Keys > Add SSH key)
    * if you don't have an FEB SSH key yet, go through the [*First time user setup*](https://github.com/tedconf/ted.com/wiki/First-time-user-setup-for-Ember-app-deploys)
    * repeat for other users who will be deploying
6. repeat steps 2-4 for your staging URL if you have one. 


### Ember setup

In your Ember app,

1. install [ember-cli-deploy](http://ember-cli-deploy.com/) and the [ember-cli-deploy-front-end-builds-pack](https://github.com/tedconf/ember-cli-deploy-front-end-builds-pack/blob/master/README.md):
    ```
    ember install ember-cli-deploy
    ember install ember-cli-deploy-front-end-builds-pack
    ```
8. Add your app name, staging url, and production url in `config/deploy.js`:
  
    ```js
    var app = 'my-app';
    var stagingHost = 'https://my-app.ted.com/';
    var productionHost = 'https://master.my-app-staging.ted.com/';
    ``` 
9. enable asset fingerprinting in `ember-cli-build.js`:
    
    Use your own app name in place of `your-app-name` in the code below.

    ```js
    var env = process.env.EMBER_ENV;
    var isProdOrStaging = (env === 'production') || (env === 'staging');
    var app = new EmberApp(defaults, {
      fingerprint: {
        enabled: isProdOrStaging,
        prepend: 'https://frontend-assets.tedcdn.com/your-app-name/',
        extensions: ['js', 'css', 'png', 'jpg', 'otf'],
      }
    });
    ```

You should now be all set to deploy!

## Deploying

#### If this is the first TED Ember app you've deployed, 

follow the [*First time user setup*](https://github.com/tedconf/ted.com/wiki/First-time-user-setup-for-Ember-app-deploys) instructions. 

#### If you haven't deployed **this** particular app before, 

1. add your front_end_builds SSH key in the [FEB admin](#managing-deploys-via-the-admin). 
2. Ensure you have access to the [correct S3 buckets](https://github.com/tedconf/ted.com/wiki/First-time-user-setup-for-Ember-app-deploys#app-specific-deploy-groups).

### To deploy to staging:
```
ember deploy staging 
```

### To deploy to production:
```
ember deploy production
```

Note: some older TED apps using the deprecated [ember-cli-front-end-builds](https://github.com/tedconf/ember-cli-front-end-builds) will use slightly different deploy commands,
```
ember deploy --environment=staging
ember deploy --environment=production
```

#### Branch deploys

You can deploy from a branch by checking out your branch locally and running the deploy command.  Note that branch deploys are *not* automatically made live, so you will need to visit the admin page to preview or manually make live your branch deploy. See [Managing deploys via the admin](#managing-deploys-via-the-admin).

