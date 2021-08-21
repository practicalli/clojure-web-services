## Initial design
The initial design is a simple copy/paste approach to see what the results look like in the web page.  Once the design has been established, the code will be refactored to reduce duplication.

```clojure
(defn accounts-overview-page
  [request]
  (response
    (html5
      {:lang "en"}
      [:head
       (include-css "https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css")]
      [:body
       [:section {:class "hero is-info"}
        [:div {:class "hero-body"}
         [:div {:class "container"}
          [:h1 {:class "title"} "Banking on Clojure"]
          [:p {:class "subtitle"}
           "Making your money immutable"]]]]

       [:section {:class "section"}
        [:article {:class "media"}
         [:figure {:class "media-left"}
          [:p {:class "image is-64x64"}
           [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-bank-coin.png"}]]]
         [:div {:class "media-content"}
          [:div {:class "content"}
           [:h3 {:class "subtitle"}
            "Current Account : &lambda;1,000,000"]
           [:p "Account number: 123456789   Sort code: 01-02-01"]]]
         [:div {:class "media-right"}
          (link-to {:class "button is-primary"} "/transfer" "Transfer")
          (link-to {:class "button is-info"} "/payment" "Payment")]]

        [:article {:class "media"}
         [:figure {:class "media-left"}
          [:p {:class "image is-64x64"}
           [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-bank-coin.png"}]]]
         [:div {:class "media-content"}
          [:div {:class "content"}
           [:h3 {:class "subtitle"}
            "Savings Account : &lambda;1,000,000 "]
           [:p "Account number: 123454321    Sort code: 01-02-01"]]]
         [:div {:class "media-right"}
          (link-to {:class "button is-primary"} "/transfer" "Transfer")
          (link-to {:class "button is-info"} "/payment" "Payment")]]

        [:article {:class "media"}
         [:figure {:class "media-left"}
          [:p {:class "image is-64x64"}
           [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-bank-coin.png"}]]]
         [:div {:class "media-content"}
          [:div {:class "content"}
           [:h3 {:class "subtitle"}
            "Tax Free Savings Account : &lambda;1,000,000 "]]]
         [:div {:class "media-right"}
          (link-to {:class "button is-primary"} "/transfer" "Transfer")
          (link-to {:class "button is-info"} "/payment" "Payment")]]

        [:article {:class "media"}
         [:figure {:class "media-left"}
          [:p {:class "image is-64x64"}
           [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-bank-coin.png"}]]]
         [:div {:class "media-content"}
          [:div {:class "content"}
           [:h3 {:class "subtitle"}
            "Mortgage Account : &lambda;1,000,000 "]
           [:p "Mortgage Reference: 98r9e8r79wr87e9232"]]]
         [:div {:class "media-right"}
          (link-to {:class "button is-primary"} "/transfer" "Transfer")
          (link-to {:class "button is-info"} "/payment" "Payment")]]

        ]])))
```


## Refactor page layout with functions
Duplicate markup code for pages can be wrapped in a helper function that generated the correct code, usually given a few specific arguments.

Its usually more effective to create the design with duplicate code first and then see the sections of code that are duplicated.


```clojure
  (defn unordered-list [items]
    [:ul
     (for [i items]
       [:li i])])

```

Many lines of code can now be reduced to a single line when adding an unordered list to a page defined with hiccup.

```clojure
  [:div
   (unordered-list ["collection" "of" "list" "items"])]
```

Applying this technique to the bank accounts overview page.  Find the code that is repeated the most and define a function containing that code.

The function should take arguments, typically a map so its more flexible in what arguments must be passed and increases the usability of the function

```clojure
(defn bank-account-media-object
  [account-details]
  [:article {:class "media"}
   [:figure {:class "media-left"}
    [:p {:class "image is-64x64"}
     [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-bank-coin.png"}]]]
   [:div {:class "media-content"}
    [:div {:class "content"}
     [:h3 {:class "subtitle"}
      (str (:account-type account-details) " : &lambda;" (:account-value account-details))]
     [:p
      (str "Account number: " (:account-number account-details) " Sort code: " (:account-sort-code account-details))]]]
   [:div {:class "media-right"}
    (link-to {:class "button is-primary"} "/transfer" "Transfer")
    (link-to {:class "button is-info"} "/payment" "Payment")]])
```

Calling the bank-account-media-object function with a map will generate the same resulting page.

```clojure
  (bank-account-media-object
    {:account-type      "Current Account"
     :account-number    "123456789"
     :account-value     "i1,000,000"
     :account-sort-code "01-02-01"})

```

Result of calling the bank-account-media-object with that map:

```clojure
;; => [:article {:class "media"} [:figure {:class "media-left"} [:p {:class "image is-64x64"} [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-bank-coin.png"}]]] [:div {:class "media-content"} [:div {:class "content"} [:h3 {:class "subtitle"} "Current Account : &lambda;" "i1,000,000"] [:p "Account number: " {:account-number {:account-type "Current Account", :account-number "123456789", :account-value "i1,000,000", :account-sort-code "01-02-01"}} " Sort code: " {:account-sort-code {:account-type "Current Account", :account-number "123456789", :account-value "i1,000,000", :account-sort-code "01-02-01"}}]]] [:div {:class "media-right"} [:a {:href #object[java.net.URI 0x3516357f "/transfer"], :class "button is-primary"} ("Transfer")] [:a {:href #object[java.net.URI 0x4cf62d27 "/payment"], :class "button is-info"} ("Payment")]]]
```

If some key/value pairs are not included, the function will still work.  Worst case is that there will be gaps where expected values would otherwise be included in the page.

Instead of many duplicate lines of code, the accounts-overview-page is reduce to less than half the code is far more readable as it is expressed as data in a hash-map.

```clojure
(defn accounts-overview-page
  [request]
  (response
    (html5
      {:lang "en"}
      [:head
       (include-css "https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css")]
      [:body
       [:section {:class "hero is-info"}
        [:div {:class "hero-body"}
         [:div {:class "container"}
          [:h1 {:class "title"} "Banking on Clojure"]
          [:p {:class "subtitle"}
           "Making your money immutable"]]]]

       [:section {:class "section"}
        (bank-account-media-object {:account-type  "Current Account" :account-number    "123456789"
                                    :account-value "1,234"       :account-sort-code "01-02-01"})

        (bank-account-media-object {:account-type  "Savings Account" :account-number    "123454321"
                                    :account-value "2,000"       :account-sort-code "01-02-01"})

        (bank-account-media-object {:account-type  "Tax Free Savings Account" :account-number    "123454321"
                                    :account-value "20,000"                :account-sort-code "01-02-01"})

        (bank-account-media-object {:account-type  "Mortgage Account" :account-number    "98r9e8r79wr87e9232"
                                    :account-value "354,000"          :account-sort-code "01-02-01"})

        ]])))
```

## Wrap results in page heading
The heading is common in all pages, so it can be extracted to a function that processes the result of all handlers, this is referred to as middleware.
