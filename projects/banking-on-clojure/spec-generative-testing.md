![Clojure specifications for next.jdbc](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure/spec/clojure-spec-blueprints-industrial.png)

Specifications define the shape of data used for the application.  The specifications are defined across two namespaces, general data specifications in `practicalli.specifications` and banking specific specs in the `practcalli.specifications-banking` namespace.


Basic customer details

```clojure
(spec/def ::first-name string?)
(spec/def ::last-name string?)
(spec/def ::email-address string?)

;; residential address values
(spec/def ::house-name-number (spec/or :string string?
                                       :number int?))
(spec/def ::street-name string?)
(spec/def ::post-code string?)
(spec/def ::county string?)
```

countries of the world as a set,
containing a string for each country
defined in the practicalli.specifications namespace

```clojure
(spec/def ::country :practicalli.specifications/countries-of-the-world)

```

```clojure
(spec/def ::residential-address (spec/keys :req [::house-name-number ::street-name ::post-code]
                                           :opt [::county ::country]))

```


```clojure
(spec/def ::social-security-id-uk string?)
(spec/def ::social-security-id-usa string?)

(spec/def ::social-security-id (spec/or ::social-security-id-uk
                                        ::social-security-id-usa))
```


```clojure
;; composite customer details specification
(spec/def ::customer-details
  (spec/keys
    :req [::first-name ::last-name ::email-address ::residential-address ::social-security-id]))
```


## Banking data specifications
The `specifications-banking` sets the overall context for the specifications defined in the namespace.

`account-id` is a unique identification across all accounts in the bank.  The type of value used is a [universally unique identifier (UUID)](https://en.wikipedia.org/wiki/Universally_unique_identifier) is a 128-bit number used to identify information in computer systems.  Clojure uses a [#uuid tag literal](https://clojure.org/reference/reader#tagged_literals)

```clojure
(spec/def ::account-id uuid?)

;; Account holder - composite specification
(spec/def ::account-holder
  (spec/keys
    :req [::account-id
          ::first-name
          ::last-name
          ::email-address
          ::residential-address
          ::social-security-id]))
```
