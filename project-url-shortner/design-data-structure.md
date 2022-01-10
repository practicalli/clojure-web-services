# Design data structure

One of the first decisions is how to design the data structure to hold our short url and full url addresses.

## The simplest approach

We could create a really simple data structure with a vector

```clojure
["goouk" "https://duckduckgo.com/"]
```

In order to hold multiple short url mappings, we could have a vector of vectors

```clojure
[["duckduckgo" "https://duckduckgo.com/"]
 ["practicalli" "https://practical.li"]
 ["slashdot" "https://slashdot.com"]]
```
Although the above is nice and simple, it does not provide any context for the data.

## Using a map for context

The keys in a map can add specific meaning and context to the design of the data structure.

Here are two examples, the first with keys as strings the second as keys as keywords.

```clojure
{"short-url" "practicalli" "full-url" "http://practical.li"}

{:short-url "practicalli" :full-url "http://practical.li"}
```

As keys need to be unique, then if we have multiple short url mappings to contain, then we need another data structure for each map.


```clojure
[{:short-url "practicalli" :full-url "http://practical.li"}
 {:short-url "slashdot" :full-url "https://slashdot.org"}]
```

In the above design we cannot use a single map as all the keys in a map need to be unique

## Simplifying the map

As keys must be unique in a map, we cannot have multiple keys called `:short-url`, therefore using that design we cant have a single map.

We could simplify the map and remove the current keys and use the value for the short-url as the key and the full url as the value.  This means we could just have a single map for all our short-url mappings.

```clojure
{"practicalli" "http://practical.li"
 "slashdot"    "https://slashdot.org"
 "duckduckgo"  "https://duckduckgo.com/"}
```

Using Clojure keywords for the keys would also allow us to look up the full url addresses using the feature of maps that make keywords act like functions.  This feature of the keyword in a map is just like calling the `get` function on the map with a specific key.

```clojure
(def url-map
  {:practicalli "http://practical.li"
   :slashdot "https://slashdot.org"
   :duck-duck-go "https://duckduckgo.com/"})

(get url-map :practicalli)
;; => "http://practicalli.co.uk"

(url-map :practicalli)
;; => "http://practicalli.co.uk"

(:practicalli url-map )
;; => "http://practicalli.co.uk"
```
