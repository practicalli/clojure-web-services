# Plumatic schema - defining the shape of data

As an API is an external system then it is important to define the shape of data coming into and leaving the application.

[Plumatic schema](https://github.com/plumatic/schema) is a simple way to define the shape of data in Clojure without having to define fixed static types.

## Dice roll result

In this example. our API is related to a game and we call our API to get the result of a dice roll

```clojure
(s/defschema DiceRollResult
  {:result s/Int})
```

## Customer

Most business systems (and most systems in general) have some concept of a user or customer.  Here we define a schema for a valid customer.

In this example, a valid customer lives in one of two cities, as defined using an schema enumeration (enum)

```clojure
(s/defschema Customer {:id      s/Str,
                       :name    s/Str
                       :address {:street s/Str
                                 :city   (s/enum :maidstone :dover)}})
```

## Pizza Order

We can make the data be as specific or as general as we need.  Enumerations allow us to limit the set of valid options.  If there were a lot of options then it may be useful to define them as a data structure in their own namespace.

```clojure
(s/defschema Pizza
  {:name           s/Str
   :size           (s/enum :L :M :S)
   :origin         {:country (s/enum :FI :PO)
                    :city    s/Str}
   (s/optional-key
     :description) s/Str})

(s/defschema Customer {:id      s/Str,
                       :name    s/Str
                       :address {:street s/Str
                                 :city   (s/enum :maidstone :dover)}})
```

## Legitimate Ferry Company

We can use the data we define to ensure that something is valid.  For example, if a Ferry company uses this API to register themselves as a business, we can ensure we capture the number of ferries they have.

In the logic of our API we can use the number of ferries value to check if we should register this company.  If it has no ferries, then we shouldn't register the company.

```clojure
(s/defschema FerryCompany
  {:name              s/Str
   :number-of-ferries Long
   :country           (s/enum :UK :France :Netherlands)
   (s/optional-key
     :description)    s/Str})
```
