# Create a new handler

> ####Note::


```clojure
(defn trying-hiccup
  [request]
  (html5 {:lang "en"}
         [:head (include-js "myscript.js") (include-css "mystyle.css")]
         [:body
           [:div [:h1 {:class "info"} "This is Hiccup"]]
           [:div [:p "Take a look at the HTML generated in this page, compared to the about page"]]
           [:div [:p "Style-wise there is no difference between the pages as we havent added anything in the stylesheet, however the hiccup page generates a more complete page in terms of HTML"]]]))
```

> ####Hint:: As your content grows its typical to refactor it into def expressions, so you can just include the names in your handler code that represent the content.

> As your project gets bigger it common to break out into a view namespace with layouts and specific views defined in their own namespace.

---

## The code so far

The code so far is available in branch `06-hiccup`
