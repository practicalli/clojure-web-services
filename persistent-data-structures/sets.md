# Theory: Sets
`#{}` is the notation for a Clojure set, a unique collection of values which does not guarantee order.

Sets are predominantly used to check if one or more values are present within a set and order is not relevant.

`set` function takes a collection of values and returns a unique collection of values.

```eval-clojure
(set [1 2 3 4 1])
```

A set can be expressed litterally using the `#{}` notation.

```eval-clojure
#{1 2 3 4 5 :a :b :c :d :e "All unique values"}
```

Define a set literally with duplicate elements will return a duplicate key error.

```eval-clojure
#{1 1 2 3 4 5 :a 1 :b 2 :c 3 :d :e "Fail: not unique values"}
```


## Are values contained in a set?
`contains?` will return `true` if a given set contains a given value.

```eval-clojure
(def evil-empire #{"Palpatine" "Darth Vader" "Boba Fett" "Darth Tyranus"})

(contains? evil-empire "Darth Vader")
```

`some` is more often used and will return the values in a set that are also contained within another set.

```eval-clojure
(some #{"Boba Fett"} evil-empire)
```


A set can also be called as a function with a value as an argument, if that value is contained within the set then that value is returned.
```eval-clojure
(#{:a :b :c} :c)
```

If the value given as an argument is not in the set, `nil` is returned
```eval-clojure
(#{:a :b :c} :z)
```



## sorted-set
A sorted set is less used, as the focus of a set collection is unquieness, it should not matter where the value is in the collection, only if that value exists.

`sorted-set` is a function that will sort the values into a unique set.

```eval-clojure
(sorted-set 1 4 0 2 9 3 5 3 0 2 7 6 5 5 3 8)
```

Values the `sorted-set` function can take as an argument are limited to those values which can be compared against each other to determine the order.  A string cannot be compared with a number or a keyword.

```eval-clojure
(sorted-set "a" \b :c 4)
```

An exception is created as the values are not comparable with each other.
