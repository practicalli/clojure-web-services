# Working with JSON files

slurp will read files into our Clojure code.

```clojure
(slurp "spicy-vegan-pepperoni.json")
```

We can use cheshire library to convert the JSON to a Clojure data structure.

```clojure
(cheshire/parse-string
  (slurp "spicy-vegan-pepperoni.json"))
;; => {"name" "Spicy Vegan Pepperoni", "size" "XL", "origin" {"country" "PO", "city" "Tampere"}, "description" "Healthy and delicious Vegan version of a double pepperoni pizza with some jalapenos to spice it up"}
```

Lets pretty print the Clojure data structure to make it easier to read

```clojure
(clojure.pprint/pprint
  (cheshire/parse-string
    (slurp "spicy-vegan-pepperoni.json")))
;; => nil

;; From the REPL output
{"name"   "Spicy Vegan Pepperoni",
 "size"   "XL",
 "origin" {"country" "PO", "city" "Tampere"},
 "description"
 "Healthy and delicious Vegan version of a double pepperoni pizza with some jalapenos to spice it up"}

```
