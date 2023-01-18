# Debugging application servers





## Debugging handlers
As handler functions are simply Clojure functions that take a request hash-map, those functions can be called from unit tests or the REPL to test they are working correctly.



## Ring mock
Generate mock requests and responses (?) for testing handler functions




## Problematic Practices to avoid

Using `(def name ,,,)` expressions for debugging is very bad, especially if those expressions are left in production code.


`(println ,,,)` statements seem convenient however have very limited value.  Using the REPL and REPL based debugging tools provide very useful output
