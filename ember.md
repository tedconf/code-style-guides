# Ember.js Style Guide

Originally forked from [DockYard's styleguide](https://github.com/dockyard/styleguides)

## Table Of Contents

- [General](#general)
- [Organizing your modules](#organizing-your-modules)
- [Computed properties](#computed-properties)
- [Controllers](#controllers)
- [Templates](#templates)
- [Routes](#routes)
- [Ember Data](#ember-data)
- [Testing](#testing)

## General

### Create local version of Ember.\* and DS.\*

Future versions of Ember will be released as ES2015 modules, so we'll be
able to import `Ember.computed` directly as `computed`. This includes
`computed.alias` or `computed.bool`, should be set to `alias` and
`bool`, respectively. Do not use extend prototype syntax

```javascript
// Good

var computed = Ember.computed;
var alias = computed.alias;
var attr = DS.attr;
var Model = DS.Model;

export default Model.extend({
  firstName: attr('string'),
  lastName: attr('string'),

  surname: alias('lastName'),

  fullName: computed('firstName', 'lastName', function() {
    // Code
  })
});

// Bad

export default DS.Model.extend({
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),

  fullName: Ember.computed('firstName', 'lastName', function() {
    // Code
  }),

  fullNameBad: function() {
    // Code
  }.property('firstName', 'lastName')
});
```

## Organizing your modules

```js
export default Component.extend({
  // Defaults
  tagName: 'span',

  // Single line CP
  post: alias('myPost'),

  // Multiline CP
  authorName: computed('author.firstName', 'author.lastName', function()
{
    // Code
  })

  actions: {
    someAction: function() {
      // Code
    }
  }
});
```

### Define default values first

Define your object's default values first.

### Define single line computed properties second

Define single line computed properties (`thing: alias('myThing')`)
after default values

### Define multi-line computed properties third

Multi-line computed properties should follow your single line CPs.

### Define actions last

Define your route/component/controller's action last, to provide a
common place that actions can be found.

### Avoid overwriting init

Unless you want to change an object's `init` function, perform actions
by hooking into the object's `init` hook via `on`. This prevents you
from forgetting to call `_super`. [Here is why you shouldn't override
init](http://reefpoints.dockyard.com/2014/04/28/dont-override-init.html).

### Use Pods structure

Store local components within their pod, global components in the
`components` structure. Use a `lib` folder for route-level components.

```
app
  application/
    template.hbs
    route.js
  blog/
    index/
      lib/
        blog-listing/ - component only used on the index template
          template.hbs
      route.js
      template.hbs
    lib
      comment-details/ - used within blog templats
        component.js
        template.hbs
    route.js
  components/
    tag-listing/ - used throughout the app
      template.hbs

  post/
    adapter.js
    model.js
    serializer.js
```

## Computed properties

### Computed properties

No computed property should be more than six lines of code. Break large
CPs into multiple properties that can be combined with additional CPs or
CPMs.

```javascript
// needs example
```

### Boolean computed 

Boolean computed properties should start with "is" or "has".

```javascript
// googd
isShowingNavBar: Ember.computed.bool('currentUser')

//bad
showNavBar: Ember.computed.bool('currentUser')
```

## Controllers

### Define query params first

For consistancy and ease of discover, list your query params first in
your contoller. These should be listed above default values.

### Do not use ObjectController or ArrayController

ObjectController is presently deprecated, and ArrayController will be as
well. Controllers are not going to be used in Ember 2.0, so by using
`Controller`, you will make it easier to migrate to 2.0.

### Alias your model

It provides a cleaner code to name your model `user` if it is a user. It
is more maintainable, and will fall in line with future routable
components

```javascript
export default Controller.extend({
  user: alias('model')
});
```

## Templates

### Do not use partials

Always use components. Partials share scope with the parent view, use
components will provide a consistent scope.

### Use block syntax

Use block syntax instead of `in` syntax with block helpers

```hbs
{{! Good }}
{{#each posts as |post|}}

{{! Bad }}
{{#each post in posts}}
```

### Use components in `{{#each}}` blocks

Contents of your each blocks should be a single line, use components
when more than one line is needed. This will allow you to test the
contents in isolation via unit tests, as your loop will likely contain
more complex logic in this case.

```hbs
{{! Good }}
{{#each posts as |post|}}
  {{post-summary post=post}}
{{/each}}

{{! Bad }}
{{#each posts as |post|}}
  <article>
    <img src={{post.image}} />
    <h1>{{post.title}}</h2>
    <p>{{post.summar}}</p>
  </article>
{{/each}}
```

## Routes

### Perform all async actions required for the page to load in `model`
hooks

The model hooks are async hooks, and will wait for any promises returned
to resolve. An example of this would be models needed to fill a drop
down in a form, you don't want to render this page without the options
in the dropdown. A counter example would be comments on a page. The
comments should be fetched along side the model, but should not block
your page from loading if the required model is there.

## Ember Data

### Be explicit with Ember Data attribute types

Even though Ember Data can be used without using explicit types in
`attr`, always supply an attribute type to ensure the right data
transform is used.

```javascript
// Good

export default Model.extend({
  firstName: attr('string'),
  jerseyNumber: attr('number')
});


// Bad

export default Model.extend({
  firstName: attr(),
  jerseyNumber: attr()
});
```

### Organize your models

Group attributes, relations, then computed properties. Organize each
subgroup alphabetically.

## Testing

To share code between setup blocks and tests, use `this.[your-prop]`. This is so QUnit can manage the lifecycle of your variables, and to prevent memory leaks from free variables. It is also how the [QUnit docs](http://api.qunitjs.com/QUnit.module/) do it.

```javascript
// good
module('my test', {
  beforeEach: function() {
    this.users = [
      {id: 1, name: 'Link'}
    ];
    this.subject.foo(this.users);
  }
});

test('link is here', function(assert) {
  assert.equal(this.users[0].name, 'Link');
});

// bad
let users = [
  {id: 1, name: 'Link'}
];
module('my test', {
  this.subject.foo(users);
});

test('link is here', function(assert) {
  assert.equal(users[0].name, 'Link');
});
```

### Page objects

Acceptance testing should use a page object. This forces you to describe your tests in words and phrases instead of CSS selectors.

* https://www.npmjs.com/package/ember-page-object

---

