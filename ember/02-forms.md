# Forms

Let's say you have a `talk` model. You make a `<talk-form>` component.

When possible, make your component work for all CRUD operations.

### Creating a model

**Getting the new model**

The simplest case is when your new model requires no collaborators, and doesn't belong to any parent model. In this case, the form can create the new model on init:

```js
export default Ember.Component({
  setup: Ember.on('init', function() {
    let talk = this.store.createRecord('talk');
    this.set('talk', talk);
  })
})
```

Once your model creation depends on other models, or the forms surroudning context, the form should no longer be responsible for creating the new model. So, instead of this:

```hbs
<talk-form session=session>
```

```js
export default Ember.Component({
  setup: Ember.on('init', function() {
    this.set('talk', session.createTalk());
  })
})
```

have the context set the new model up, and pass it into the form. For example, if you have a route dedicated to the creation of the model, have the route set up the new model:

```js
export default Ember.Route({
  model() {
    return this.modelFor('session').createTalk();
  }
});
```

```hbs
<talk-form talk=model>
```

If your create form will be displayed in some component, have that component set up the model:

```js
// Session Show component
export default Ember.Component({
  session: null,
  newTalk: null,

  actions: {
    createTalk() {
      this.set('newTalk', this.get('session').createTalk());
    }
  }
})
```

```hbs
<session-show session=session>
```

```hbs

session name: {{session.name}}

{{#if newTalk}}
  <talk-form talk=newTalk>
{{/if}}

<a {{action "newTalk"}}>Add new talk</a>
```

In this example, we've encapsulated the creation of a talk to the <session-show>, since the session owns the talk. This is great for refactoring, since as long as you pass in a session to the <session-show> component, everything in its component tree (including the <talk-form>) works.

**Persisting the new model**

[some reasoning for why we feel saving models outside of the ui is justified, e.g. why data-down-actions-up isn't ]

Typically, after inputing the data for your new model, users will be able to either save it or discard it.

When saving the new model, use an action on your form component to save the model directly. Try to use a `<form>` with `submit` action, to follow HTML spec as close as possible.

If the save operation fails, the model itself will be in an error state. More sophisticated applications will use this to display appropriate error messages, but at a minimum your form component should notify the user in a `catch` block.

```hbs
<form {{action 'save' on='submit'}}>
  ...

  {{ted-model-errors model=talk}}

  <input type='submit' value='Save your talk'>
</form>
```

```
// talk-form/component.js
export default Ember.Component({
  actions: {
    save() {
      return this.get('talk').save()
        .catch(() => {
          this.get('flashMessages').toast('Error', {
            text: 'There was an error',
            icon: 'exclamation'
          });
        });
    }
  }
})
```

It's often useful to send a `did-save` action after your form has successfully saved the new model, so parent components can update the ui. Prefer to keep ui error handling code in the form.

```js
this.get('talk').save()
  .then(() => { this.get('did-save')(); })
  .catch(() => {
    // show errors
  });
```

For more sophisticated server error handling, see [here]().

**Discarding the new model**

If the user cancels the creation of the new model, and you want the parent to update the ui, have the form send a `did-cancel` action:

You can optionally clean up the new record from the form component.

```js
// talk-form/component.js
export default Ember.Component({
  actions: {
    cancel() {
      this.get('talk').deleteRecord();
      this.get('did-cancel')();
    }
  }
})
```

**Creating related models**


this.get('talk').saveAll();

There's a separate guide on this.

### Editing a model

### Deleting a model

### Adding clientside validations
