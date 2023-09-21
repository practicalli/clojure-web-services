# Portal

Start Portal and capture all evaluation results over nrepl when portal middleware included in the REPL startup.

All evaluation carried out over nREPL, i.e. between the connected editor and the Clojure REPL, will be sent to Portal.

Use [:fontawesome-solid-book-open: Practicalli Clojure CLI Config]() aliases or define your own alias in the project or user `deps.edn` file.


=== "Practicalli Clojure CLI Config"
    `:repl/reloaded` aliases from [:fontawesome-solid-book-open: Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/) starts a REPL process with Portal and nrepl middleware

    Connect an editor to the REPL via the nREPL server port created during the REPL startup

    !!! NOTE ""
        ```shell
        clojure -M:repl/reloaded
        ```

    > `make repl` also launches Portal listening over nREPL in projects created with [:fontawesome-solid-book-open: Practicalli Project Templates](https://practical.li/clojure/clojure-cli/projects/templates/practicalli/)


=== "Alias definition"

    Define an alias that includes the portal library in the `:extra-deps` section and `portal.nrepl/wrap-portal` nrepl middleware in the `:main-opts` section with the `--middleware` flag.

    !!! EXAMPLE "Clojure CLI alias including Portal & nREPL middleware"
        ```clojure
        :repl/reloaded
        {:extra-paths ["dev" "test"]
         :extra-deps {nrepl/nrepl                  {:mvn/version "1.0.0"}
                      cider/cider-nrepl            {:mvn/version "0.37.0"}
                      com.bhauman/rebel-readline   {:mvn/version "0.1.4"}
                      djblue/portal                {:mvn/version "0.46.0"}
                      clj-commons/clj-yaml         {:mvn/version "1.0.27"}
                      org.clojure/tools.namespace  {:mvn/version "1.4.4"}
                      org.clojure/tools.trace      {:mvn/version "0.7.11"}
                      org.slf4j/slf4j-nop          {:mvn/version "2.0.9"}
                      com.brunobonacci/mulog       {:mvn/version "0.9.0"}
                      lambdaisland/kaocha          {:mvn/version "1.86.1355"}
                      org.clojure/test.check       {:mvn/version "1.1.1"}
                      ring/ring-mock               {:mvn/version "0.4.0"}
                      criterium/criterium          {:mvn/version "0.4.6"}}
         :main-opts  ["-e" "(apply require clojure.main/repl-requires)"
                      "--main" "nrepl.cmdline"
                      "--middleware" "[cider.nrepl/cider-middleware,portal.nrepl/wrap-portal]"
                      "--interactive"
                      "-f" "rebel-readline.main/-main"]}
        ```

## Launching Portal

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

## Themes

A [portal theme](https://cljdoc.org/d/djblue/portal/0.37.1/doc/ui-concepts/themes) can be specified when starting portal, e.g. `:portal.colors/gruvbox`.


## Reference Docs

[Portal nREPL connection documentation](https://cljdoc.org/d/djblue/portal/0.46.0/doc/guides/nrepl){target=_blank .md-button} 
