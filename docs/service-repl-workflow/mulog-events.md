# Mulog

[:fontawesome-brands-github: Mulog](https://github.com/BrunoBonacci/mulog) is library that defines log events as data, with a wide range of publisher for [:globe_with_meridians: popular log aggregation services](https://github.com/BrunoBonacci/mulog#publishers), e.g. Elastic Search, Cloudwatch, Kinesis, Prometheus, etc.)

Creating a custom publisher, all mulog events can be sent to portal data inspector.

![Portal - mulog event messages tap>](https://github.com/practicalli/graphic-design/blob/live/portal/portal-mulog-tap-publisher-repl-startup-dark.png?raw=true){loading=lazy}


## Mulog configuration

`mulog/set-global-context!` defines key/value pairs included in every mulog event allowing a separate context to be used for logs, e.g. `:env :dev` indicating development time events.

`TapPublisher` defines a custom Mulog publisher which wraps `tap>` around every mulog event created, sending each mulog event to Portal.

`tap-publisher` is a var that starts the custom mulog publisher, providing a reference to the publisher so it can be shut down.

`stop` function is provided as a convienient way to stop the publisher via the REPL.

!!! EXAMPLE "Mulog events publisher"
    ```clojure title="dev/mulog_events.clj"
    ;; ---------------------------------------------------------
    ;; Mulog Global Context and Custom Publisher
    ;;
    ;; - set event log global context
    ;; - tap publisher for use with Portal and other tap sources
    ;; - publish all mulog events to Portal tap source
    ;; ---------------------------------------------------------

    (ns mulog-events
      (:require
       [com.brunobonacci.mulog        :as mulog]
       [com.brunobonacci.mulog.buffer :as mulog-buffer]))

    ;; ---------------------------------------------------------
    ;; Set event global context
    ;; - information added to every event for REPL workflow
    (mulog/set-global-context! {:service-name "todo-tracker Service",
                                :version "0.1.0", :env "dev"})
    ;; ---------------------------------------------------------

    ;; ---------------------------------------------------------
    ;; Mulog event publishing

    (deftype TapPublisher
             [buffer transform]
      com.brunobonacci.mulog.publisher.PPublisher
      (agent-buffer [_] buffer)
      (publish-delay [_] 200)
      (publish [_ buffer]
        (doseq [item (transform (map second (mulog-buffer/items buffer)))]
          (tap> item))
        (mulog-buffer/clear buffer)))

    #_{:clj-kondo/ignore [:unused-private-var]}
    (defn ^:private tap-events
      [{:keys [transform] :as _config}]
      (TapPublisher. (mulog-buffer/agent-buffer 10000) (or transform identity)))

    (def tap-publisher
      "Start mulog custom tap publisher to send all events to Portal
      and other tap sources
      `mulog-tap-publisher` to stop publisher"
      (mulog/start-publisher!
       {:type :custom, :fqn-function "mulog-events/tap-events"}))

    #_{:clj-kondo/ignore [:unused-public-var]}
    (defn stop
      "Stop mulog tap publisher to ensure multiple publishers are not started
     Recommended before using `(restart)` or evaluating the `user` namespace"
      []
      tap-publisher)

    ;; Example mulog event message
    ;; (mulog/log ::dev-user-ns :message "Example event message" :ns (ns-publics *ns*))
    ;; ---------------------------------------------------------
    ```

