# Work in Progress

## Variable tag names

I have slightly variable html tag content based on some config being passed into a reagent component. I want to output "adjacent" divs with an incrementing index value on the end of the class name.

```clojure
[:div.row-data
        (for [heading column-headings]
          (let [heading-tag-with-class (str "div.column-heading.column-heading-" (count (:display-names heading)))]
            [(keyword heading-tag-with-class) {:key (:symbol heading)}
```

This solution works, is a better way?.

Dominic
```clojure
[:div.column-heading
  {:class (str "column-heading-" (count (:display-names heading)))}]
```
