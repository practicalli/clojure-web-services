# Crux - bi-temporal schema-less document database
[Crux](https://opencrux.com/) is a general purpose database with graph-oriented bitemporal indexes. Datalog, SQL & EQL queries are supported along with Java, HTTP & Clojure APIs.  The Datalog query interface that can be used to express complex joins and recursive graph traversals.

## Getting Started
Follow the [Crux Earth Assignment Tutorial](https://juxt.pro/blog/crux-tutorial-setup), in either the self-contained [Next-Journal environment](https://nextjournal.com/crux-tutorial/) or as your own Clojure project.

{% tabs clojure="Clojure CLI tools", lein="Leiningen" %}

{% content "clojure" %}
Using the Clojure CLI tools and practicalli/clojure-deps-edn configuration, create a new project:

```bash
clojure -X:project/new :template app :name practicalli/crux-demo
```

{% content "lein" %}
Using the Leiningen build tool, create a new project:

```bash
lein new app practicalli/crux-demo
```

{% endtabs %}

[Install Crux](https://opencrux.com/reference/installation.html) as a library in a Clojure project or use the pre-built dockker image.

> Note: to have more than one set of tabs in a page, simply create unique id's for the tabs, e.g. practicalli2


Experiment with the [Crux-labs workshop project](https://github.com/crux-labs/reclojure-workshop), which contains examples of using Crux.


## Resources
* [Library dependency (clojars)](https://github.com/juxt/crux/releases)
* [Reference Documentation](https://opencrux.com/reference)
* [Community discussions (Zulip)](https://juxt-oss.zulipchat.com/#narrow/stream/194466-crux)
* [GitHub discussions](https://github.com/juxt/crux/discussions)

{% youtube %}
https://www.youtube.com/watch?v=JkZfQZGLPTA
{% endyoutube %}


## Unbundled architectural overview
Crux follows an unbundled architectural, decoupled components communicating via an immutable log and document store. `crux-rocksdb` is the high performance default data store, with a range of storage options available for embedded usage and cloud scaling.

Crux embraces the transaction log as the central point of coordination when running as a distributed system. Use of a separate document store enables simple eviction of active and historical data to assist with technical compliance for information privacy regulations.

This design makes it feasible and desirable to embed Crux nodes directly within your application processes, which reduces deployment complexity and eliminates round-trip overheads when running complex application queries.

![Crux - unbundled architectural overview](https://raw.githubusercontent.com/juxt/crux/master/docs/about/modules/ROOT/images/crux-node-1.svg)
