# Aero - manage environment profiles

aero provides a way to define multiple environment profiles.  A specific profile is used to parse the Integrant configuration, resulting in specific values for each key.

As each part of the system can be defined using profiles, the same `resources/config.edn` configuration can be used for both Integrant and Integrant REPL
