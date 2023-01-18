## Theory: maps and keywords

When a request is received by our application, it is converted from by Jetty to a servlet request.  Ring then converts this to a Clojure map called `request`.  All handlers in our application take a request map as an argument.

A map in Clojure contains one or more key / value pairs, you may be familiar with the term _hash map_.  The keys in these maps are often defined using a Clojure _keyword_.  A keyword is a symbol that points to itself and so therefore is unique within a specific scope.  A keyword makes it very easy to get a value from a map and acts as a function on the map to return its associated value

So, assume we have defined a map called `request`. This map contains a key defined with the `:uri` keyword. We can get the value associated with the key using the keyword as a function

```clojure
(def request {:uri "/"})

(:uri request)

;; As a map can also act as a function to get its elements, you can also use the following form to get the same value
(request :uri)
```

The function `get` is functions that helps us get data from maps.  The function `get-in` helps us get data from nested levels of maps.
