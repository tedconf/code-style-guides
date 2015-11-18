import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {

  this.route('ember', function() {
    this.route('pods');
    this.route('ember-data');
    this.route('components');
    this.route('forms');
    this.route('error-handling');
    this.route('old');
  });

  this.route('css', function() {

  });

  this.route('ruby', function() {
    this.route('rspec');
  });

});

export default Router;
