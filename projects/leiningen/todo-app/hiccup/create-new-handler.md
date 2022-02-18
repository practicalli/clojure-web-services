# Create a new handler


```clojure
(defn trying-hiccup
  [request]
  (html5 {:lang "en"}
         [:head (include-js "myscript.js") (include-css "mystyle.css")]
         [:body
           [:div [:h1 {:class "info"} "This is Hiccup"]]
           [:div [:p "Take a look at the HTML generated in this page, compared to the about page"]]
           [:div [:p "Style-wise there is no difference between the pages as we haven't added anything in the stylesheet, however the hiccup page generates a more complete page in terms of HTML"]]]))
```

> ####Hint::Named content sections
> As content grows, refactor it into `def` expressions to give content sections names. Pages can use names in the handler code that represent the content, simplifying the handler code.
>
> As the project grows, break code into a view namespace with layouts and specific views defined in their own namespace.


<!-- ## The code so far -->

<!-- The code so far is available in branch `06-hiccup` -->
