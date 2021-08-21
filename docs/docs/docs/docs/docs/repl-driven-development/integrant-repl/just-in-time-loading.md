# Just In Time Loading of depenencies

In the [LambdaIsland article - Integrant in practice](https://lambdaisland.com/blog/2019-12-11-advent-of-parens-11-integrant-in-practice), a technique is used to load only the namespaces required to make Integrant REPL and Aero work.

This should save a few micro-seconds in REPL start time, although the usual require approach is still very fast with Clojure CLI tools.

> #### TODO::work in progress, sorry
> TODO: create example of just-in-time loading of dependencies for scoreboard project
