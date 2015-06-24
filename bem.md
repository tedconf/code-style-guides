# CSS guidelines

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

## Sources

The guidelines found in this document were adapted from the following sources:

* Harry Roberts' [CSS Guidelines](http://cssguidelin.es/): BEM-like class name notation
