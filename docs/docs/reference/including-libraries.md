# Including Libraries


## Adding dependencies in Leinningen



## Requiring namespaces


See the [clojure docs for require][1]. Here's an example where the namespace is given the alias `r` so that you can shorten the names.

    (require [interview.prompts.rawlist :as r])
    (r/your-function)

You can also refer to the full name at any time too:

    (interview.prompts.rawlist/another-fn)

There are many ways to use require, e.g. with refer if you don't want a prefix. Say you have 3 functions f1,f2,f3, then you can refer to them in these ways:

    (require [interview.prompts.rawlist :refer [f1 f2] :as r)
    (f1)
    (f2)
    (r/f3)

Notice in third case, because it wasn't in the refer list, you have to use the `r` prefix.

For test folders, read the [documentation for leiningen][2] where it is explained, but basically boils down to:

    + /interview
    |--+ src/
    |--+ test/

and the sub-folder structure follows exactly the same pattern as the src dir.

You can add additional folders in `project.clj` using `:source-paths` and `:test-paths` keys in the main project macro. See [the sample project][3] for more information.

I recommend you absorb everything in the sample project above, and also read the [leiningen tutorial][4].

Finally, when referring to functions in the [`ns` declaration][5] in other sources (e.g. in your tests) you use the same format, but using the `:require` form:

    (ns foo.bar
      (:require [interview.prompts.rawlist :as r]))

    (r/foo-fn)

> Elaborated from [a stack exchange answer on the use of namespaces](http://stackoverflow.com/questions/31129544/clojure-and-leiningen-declare-and-require-namespace) by [Mark Fisher](http://stackoverflow.com/users/690139/mark-fisher)

  [1]: https://clojuredocs.org/clojure.core/require
  [2]: https://github.com/technomancy/leiningen/blob/master/doc/TUTORIAL.md#checkout-dependencies
  [3]: https://github.com/technomancy/leiningen/blob/master/sample.project.clj
  [4]: https://github.com/technomancy/leiningen/blob/master/doc/TUTORIAL.md
  [5]: https://clojuredocs.org/clojure.core/ns


## Using Libraries 

The `use` function also makes another libraries namespace accessible to the current one.  However `use` includes everything from the other library, it also makes everything part of the same namespace (ie. as if the functions, macros, name bindngs, etc were written in your library).

Therefore the `use` function is usually avoided and `require` is used instead.  However, it can be convenient to make use of the 'use' function within the REPL as a way to include your project within the `user` namespace.  Being in the `user` namespace gives you access to the REPL tools (eg. `doc`, `source`, etc)


### Example

Lets make use of the `use` function to include a library called `really-useful-code.core`


```clojure
(use 'really-useful-code.core)
```
