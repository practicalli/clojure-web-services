# Hiccup - HTML Library

Hiccup is a library for generating HTML from Clojure, keeping your code consistent and easier to write and maintain.

Using HTML, a heading would be written as:

```html
<h1 class='heading'>I am a heading</h1>
```

Hiccup uses vectors to define HTML tags and maps to represent styles and other attributes.  So the same heading in Hiccup would be written as:

```clojure
[:h1 {:class "heading"} "I am a heading"]
```



## Using Hiccup

Add the hiccup dependency to your `project.clj` file

```
[hiccup "1.0.5"]
```

In the REPL, require the hiccup.core library

```clojure
user=> (require '[hiccup.core :as markup])
;; => nil
```

Or add hiccup to the namespace definition in your Clojure code file.

```clojure
(ns my-namespace.core
  (require '[hiccup.core :as markup]))
```



## Writing Hiccup

Here is a basic example of Hiccup syntax:

```clojure
(markup/html [:span {:class "foo"} "bar"])
;; => "<span class=\"foo\">bar</span>"
```

The first element of the vector is used as the element name. The second attribute can optionally be a map, in which case it is used to supply the element's attributes. Every other element is considered part of the tag's body.

Hiccup is intelligent enough to render different HTML elements in different ways, in order to accommodate browser quirks:

```clojure
(markup/html [:script])
;; => "<script></script>"

(html [:p])
;; =>  "<p />"
```

And provides a CSS-like shortcut for denoting `id` and `class` attributes:

```clojure
(markup/html [:div#foo.bar.baz "bang"])
;; =>  "<div id=\"foo\" class=\"bar baz\">bang</div>"
```

When writing multiple lines of hiccup markup, wrap them in either a `[:div ]` or a `(list )` expression.

```clojure
[:div
  [:h1 "My Picture Album"]
  [:img {:src seaside.png} "A sunny seaside view"]
  [:img {:src pier.png} "A walk along the pier"]]
```


If the body of the element is a seq, its contents will be expanded out into the element body. This makes working with forms like `map` and `for` more convenient:

```clojure
(html [:ul
  (for [x (range 1 4)]
    [:li x])])
;; => "<ul><li>1</li><li>2</li><li>3</li></ul>"
```


```clojure
(html
  [:ul
  (for [x (range 1 4)]
    [:li x])])
;; => "<ul><li>1</li><li>2</li><li>3</li></ul>"
```



The parent tag will still be rendered in the above example, so

> **Hint** Hiccup reference and guides
> * [Hiccup API](https://weavejester.github.io/hiccup/)
> * [Hiccup Tips - Lisp Cast](https://lispcast.com/hiccup-tips/)
