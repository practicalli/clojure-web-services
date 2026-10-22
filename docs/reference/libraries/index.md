# Libraries

Essential libraries to support Clojure Web Services.

## Logging

Practicalli team recommends these logging libraries:

- [mulog](./logging/mulog.md) event logging using object rather than text
- [telemere](https://github.com/taoensso/telemere){target=_blank} (replaces Timbre) api for string based and structured logs

Clojure standard library includes [tools.logging](https://clojure.github.io/tools.logging/){target=_blank} which provides macros to delegate to a logging implementation selected at runtime.

Log4j & SLF4j is a logging approach built on top of the common Java approach to logging. This approach can be unnecessarily complex and the Practicalli team does not recommend this approach.
