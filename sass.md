# Sass guidelines

## BEM-like naming

When creating styles for components, we use class names that follow
a convention adapted from the BEM (_Block_, _Element_, _Modifier_)
front-end methodology:

* Block: the class that will be applied to the component root.
* Element: a descendant element of the block or of another element.
* Modifier: a state or version of a block or element.

The CSS class names we use look like this:

```css
.Block {}
.Block__element {}
.Block--modifier {}
```

* Block names always start with a capital letter.
* Two underscores are used to adjoin an element.
* Two hyphens are used to adjoin a modifier.
* A single hyphen (spinal case) is used to separate multiple words
  within block, element, and modifier names.
  e.g., `Block-name__element-name--modifier-name`
* Elements may have their own modifiers.
  e.g., `Block__element--modifier`

### Example

Here is a trivial example demonstrating how BEM-like names might be
used in CSS and applied in HTML:

```css
.Figure {}
.Figure__image {}
.Figure__caption {}
.Figure--alt{}
```

```html
<figure class="Figure Figure--alt">
  <img class="Figure__image" src="…" alt="…">

  <figcaption class="Figure__caption">
    …
  </figcaption>
</figure>
```

## Utility Classes

Though it's best to stick with BEM in most cases to avoid style conflicts, gloabal utilty classes can be helpful for small bits of style that will be used repeatedly.

* Utility classes always start with a lowercase letter (to distinguish them from BEM classes).
* Use caution when editing utility classes. They are not scoped like BEM classes and will affect the whole app.

```css
.capitalize {
  text-transform: uppercase;
}
```

## "Mobile first" media query arrangements

Base styles should be written for the smallest screens. Media queries should be used to introduce modified styles for progressively larger screens:

```sass
.Block {
  padding: 10px;

  @media all and (min-width: 600px) {
    padding: 20px;
  }

  @media all and (min-width: 900px) {
    padding: 40px;
  }

  @media all and (min-width: 1200px) {
    padding: 60px;
  }
}
```

## Organize code by class, not breakpoint

In general, organize your code by classes, and put media queries within those classes:

```sass
.Block {
  padding: 10px;

  @include respond-to(768px) {
    padding: 20px;
  }
}
```

For dramatic layout changes, it may be more appropriate to organize styles primarily by breakpoint:

```sass
.Block {
  padding: 10px;
}

.Block__element {
  margin: 10px;
}

@include respond-to(768px) {
  .Block {
    position: absolute;
    top: 0;
    left: 20px;
  }

  .Block__element {
    visibility: hidden;
  }
}
```

Never use selectors inside a nested media query (e.g., never declare a class inside a media query inside a class):

```sass

.Block {
  padding: 10px;

  @include respond-to(768px) {
    // don't do this!
    .button {
      padding: 20px;
    }
  }
}
```

Be mindful that every media query costs ~30 bytes in the output: if you're using a lot of media queries, please refactor your Sass to the breakpoint-first style or layer on additional post-processing to consolidate media queries.

## Sources

The guidelines found in this document were adapted from the following sources:

* Harry Roberts' [CSS Guidelines](http://cssguidelin.es/): BEM-like class name notation
