import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('ember');
  this.route('css');
  this.route('ruby');
});

export default Router;
