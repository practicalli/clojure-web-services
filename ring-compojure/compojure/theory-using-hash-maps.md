# Theory: Accessing Maps

The request is a Clojure map made up of keys and values.  The keys are Clojure keywords.  Some of the values in a map are also represented as maps

Here is an example of a request map

```clojure
{:request-params {:name "John"}}
```

Using the `get` function we can pull out the value for a particular keyword in the map

```clojure
(get map :keyword)
```

You can use `get` with a nested map, however you would need a nested `get` funciton call

```clojure
(get (get outer-map :outer-keyword) :inner-keyword)
```

With many nested maps, the `get` function can lead to code that is harder to read.  Using the `get-in` function provides a simpler syntax for traversing nested maps


```clojure
(get-in map [:outer-keyword :inner-keyword]
```


## Using keywords and maps

You can also use keywords to extract values from maps when using the keywords as the keys

```clojure
(def response-map {:name "john" :path "/helo"}
```

You can get the value from this map using the keywork

```clojure
(response-map :name)

=> "john"

(response-map :path)

=> "/hello"
```
