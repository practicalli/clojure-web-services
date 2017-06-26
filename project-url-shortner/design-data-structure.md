# Design data structure

One of the first decisions is how to design the data structure to hold our short url and full url addresses.

## The simplest approach 

We could create a really simple data structure with a vector 

```clojure
["goouk" "https://google.co.uk"]
```

In order to hold multiple short url mappings, we could have a vector of vectors

```clojure
[["goouk" "https://google.co.uk"]
 ["jrock" "http://jr0cket.co.uk"]
 ["slash" "https://slashdot.com"]]
```
Although the above is nice and simple, it does not provide any context for the data.

## Using a map for context

The keys in a map can add specific meaning and context to the design of the data structure.

Here are two examples, the first with keys as strings the second as keys as keywords.

```clojure
{"short-url" "jrock" "full-url" "http://jrocket.co.uk"}

{:short-url "jrock" :full-url "http://jrocket.co.uk"}
```

As keys need to be unique, then if we have multiple short url mappings to contain, then we need another data structure for each map.


```clojure
[{:short-url "jrock" :full-url "http://jrocket.co.uk"}
 {:short-url "slash" :full-url "https://slashdot.com"}]
```

In the above design we cannot use a single map as all the keys in a map need to be unique

## Simplifying the map

As keys must be unique in a map, we cannot have multiple keys called `:short-url`, therefore using that design we cant have a single map.

We could simplify the map and remove the current keys and use the value for the short-url as the key and the full url as the value.  This means we could just have a single map for all our short-url mappings.

```clojure
{"jrock" "http://jrocket.co.uk"
 "slash" "https://slashdot.org"
 "goouk" "https://google.co.uk"}
```

Using Clojure keywords for the keys would also allow us to look up the full url addresses using the feature of maps that make keywords act like functions.  This feature of the keyword in a map is just like calling the `get` function on the map with a specific key.

```clojure
(def url-map 
  {:jrock "http://jrocket.co.uk"
   :slash "https://slashdot.org"
   :goouk "https://google.co.uk"})

(get url-map :jrock)
;; => "http://jrocket.co.uk"

(url-map :jrock)
;; => "http://jrocket.co.uk"
```
