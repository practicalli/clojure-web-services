# Portal

Start Portal and capture all evaluation results over nrepl when portal middleware included, via `:repl/reloaded` or `:dev/reloaded` aliases from [Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/).  

Optionally supply a [portal theme](https://cljdoc.org/d/djblue/portal/0.37.1/doc/ui-concepts/themes).

!!! EXAMPLE "Start Portal listening to all evaluations"
```clojure title="dev/portal.clj"
(ns portal
  (:require
   [portal.api :as inspect]))

(def instance
  "Open portal window if no portal sessions have been created.
   A portal session is created when opening a portal window"
  (or (seq (inspect/sessions))
      (inspect/open {:portal.colors/theme :portal.colors/gruvbox})))

;; Add portal as tapsource (add to clojure.core/tapset)
(add-tap #'portal.api/submit)
```


