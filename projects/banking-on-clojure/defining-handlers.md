# Defining additional request handlers
Taking an outside-in approach, the main parts of the website user interface will be created using Hiccup and Bulma CSS library.  Mock data will be used then wired up to the database as that is designed.

> #### INFO::Inside-out development
> If writing a webapp for an existing database design, taking an inside-out approach my be more effective.  In that approach database access functions would be created and then handlers to expose that data.  Then UI elements would be added to the handlers to make a functioning and responsive application.`

## Request Handlers
The following request handlers will be created for the banking-on-clojure application

* welcome-page
* register-account-holder
* accounts-overview-page
* account-history
* money-transfer
* money-payment

All handlers are very similar to the welcome page, which highlights that some common template should be created for all handlers to use.

The accounts-overview-page is the main page for the application, so will be designed in more detail.


## account-overview-page handler
This is the page customers will view by default when logging in.

```clojure
(defn accounts-overview-page
  "Overview of each bank account owned by the current customer.

  Using Bulma media object style
  https://bulma.io/documentation/layout/media-object/

  Request hash-map is not currently used"

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
                                    :account-value "1,234"           :account-sort-code "01-02-01"})

        (bank-account-media-object {:account-type  "Savings Account" :account-number    "123454321"
                                    :account-value "2,000"           :account-sort-code "01-02-01"})

        (bank-account-media-object {:account-type  "Tax Free Savings Account" :account-number    "123454321"
                                    :account-value "20,000"                   :account-sort-code "01-02-01"})

        (bank-account-media-object {:account-type  "Mortgage Account" :account-number    "98r9e8r79wr87e9232"
                                    :account-value "354,000"          :account-sort-code "01-02-01"})

        ]])))
```

This handler uses a helper function to reduce the amount of hiccup code.

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
      (str (:account-type account-details) " : &lambda;" (:account-value account-details))]]

    [:div {:class "field is-grouped"}
     [:div {:class "control"}
      [:div {:class "tags has-addons"}
       [:span {:class "tag"} "Account number"]
       [:span {:class "tag is-success is-light"} (:account-number account-details)]]]

     [:div {:class "tags has-addons"}
      [:span {:class "tag"} "Sort Code"]
      [:span {:class "tag is-success is-light"} (:account-sort-code account-details)]]]]

   [:div {:class "media-right"}
    (link-to {:class "button is-primary"} "/transfer" "Transfer")
    (link-to {:class "button is-info"} "/payment" "Payment")]])
```
