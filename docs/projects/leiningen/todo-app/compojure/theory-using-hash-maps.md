# Theory: Accessing hash-maps
The request is a Clojure hash-map made up of key / value pairs, referred to as the request map.  The keys are Clojure keywords.  The values are typically strings or Clojure collections (vectors, hash-maps).

Here is an example of a request map

```clojure
{:request-params {:name "John"}}
```

Using the `get` function to return the value for a particular keyword in the request-map

```clojure
(get request-map :keyword)
```

## Using hash-map as a function
A hash-map can be evaluated as a function call to the map with the key as an argument.  Any type of key can be used in this expression.

```clojure
(request-map :keyword)
(request-map "key as string")
```

## Nested hash-maps
Two `get` expressions could be used to return a particular value when accessing a nested hash-map.  The inner get expression returns a hash-map and the outer get expression returns the value.

```clojure
(get (get outer-map :outer-keyword) :inner-keyword)
```

With many nested maps, the `get` function can lead to code that is harder to read.  Using the `get-in` function provides a simpler syntax for traversing nested maps

`get-in` walks through the nested hash-map along the path defined by the vector of keys.

```clojure
(get-in request-map [:outer-keyword :inner-keyword])
```


## Using keywords and hash-maps
Keywords can be evaluated as a function call with a hash-map as an argument and return their associated value in that hash-map.

```clojure
(def response-map {:name "john" :path "/hello"}
```

You can get the value from this map using the keyword

```clojure
(response-map :name)

=> "john"

(response-map :path)

=> "/hello"
```

Other types of keys do not work as function calls.  Either use the map as a function with the key as an argument or use the `get` and `get-in` functions as appropriate.
