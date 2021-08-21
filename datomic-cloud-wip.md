## compile datomic ions


https://clojurians.slack.com/archives/C03S1KBA2/p1598653040371500

using Datomic Cloud and compiling code before deployment to catch any errors without incurring AWS costs.

using depstar but don't have a -main since deploying Ions. how to do the compilation?

Do Ions not have a standard entry point?
(I am not familiar with them)

No, the entry point is in Datomic Cloud...

Yeah, but how does it know what to call in your Ion code?

The general answer here is:
1. create a classes folder
2. add it to your :paths in deps.edn
3. run clojure -e "(compile,'your.namespace)" to compile stuff
4. run depstar so it will JAR up the source and the classes

Or if you only care about putting the source in the JAR, but want to do the compile as a sanity check, add a :compile alias that has :main-opts ["-e" "(compile,'your.namespace)"] and then clojure -A:compile and don't both putting "classes" in your :paths -- you still need the folder for compile to compile into.
