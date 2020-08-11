# Base routes


> ####Note:: Create a new file called `src/todo_list/handlers/base-routess.clj` and move all the handler code into this file from `src/todo_list/core`.  Make sure you also move the `hiccup` libraries into the new `handlers` namespace.



`handlers.clj` should look as follows:


```clojure
(ns todo-list.handlers
   (:use
     [hiccup.core]
     [hiccup.page]))


(defn welcome
  "A ring handler to respond with a simple welcome message"
  [request]
  (html [:h1 "Hello, Clojure World"]
        [:p "Welcome to your first Clojure app, I now update automatically"]))

(defn goodbye
  "A song to wish you goodbye"
  [request]
    (html5 {:lang "en"}
           [:head (include-js "myscript.js") (include-css "mystyle.css")]
           [:body
            [:div [:h1 {:class "info"} "Walking back to happiness"]]
            [:div [:p "Walking back to happiness with you"]]
            [:div [:p "Said, Farewell to loneliness I knew"]]
            [:div [:p "Laid aside foolish pride"]]
            [:div [:p "Learnt the truth from tears I cried"]]]))

(defn about
  "Information about the website developer"
  [request]
  (html [:h1 "About the Website"]
        [:p "I am an awesome Clojure developer, well getting there... trying some Hiccup now"]))

(defn hello
  "A simple personalised greeting showing the use of variable parth elements"
  [request]
  (let [name (get-in request [:route-params :name])]
    {:status 200
     :body (str "Hello " name ".  I got your name from the web URL")
     :headers {}}))

(def operands {"+" + "-" - "*" * ":" /})

(defn calculator
  "A very simple calculator that can add, divide, subtract and multiply.  This is done through the magic of variable path elements."
  [request]
  (let [a  (Integer. (get-in request [:route-params :a]))
        b  (Integer. (get-in request [:route-params :b]))
        op (get-in request [:route-params :op])
        f  (get operands op)]
    (if f
      {:status 200
       :body (str "<h1>Result = " (f a b) "</h1>")
       :headers {}}
      {:status 404
       :body "Sorry, unknown operator.  I only recognise + - * : (: is for division)"
       :headers {}})))

(defn trying-hiccup
  [request]
  (html5 {:lang "en"}
         [:head (include-js "myscript.js") (include-css "mystyle.css")]
         [:body
           [:div [:h1 {:class "info"} "This is Hiccup"]]
           [:div [:p "Take a look at the HTML generated in this page, compared to the about page"]]
           [:div [:p "Style-wise there is no difference between the pages as we havent added anything in the stylesheet, however the hiccup page generates a more complete page in terms of HTML"]]]))
```
