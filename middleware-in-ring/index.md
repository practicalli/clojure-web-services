# Middleware in Ring

Middleware in ring is a way to modify the incoming requests or outgoing responses.

Middleware can also wrap handlers or other middleware, affecting their behaviour.  For example the `wrap-reload` middleware enables live reloading by detecting file changes and reloading affected functions into their namespace, before the request is passed to the relevant handler function

Here is a list of middleware available in Ring itself:

`ring/ring-core` middleware includes:
   * [wrap-cookies](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/cookies.clj#L124) (ring.middleware.cookies)
   * [wrap-file](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/file.clj#L14) (ring.middleware.file)
   * [wrap-file-info](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/file_info.clj#L89) (ring.middleware.file-info)
   * [wrap-flash](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/flash.clj#L4) (ring.middleware.flash)
   * [wrap-keyword-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/keyword_params.clj#L15) (ring.middleware.keyword-params)
   * [wrap-multipart-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/multipart_params.clj#L60) (ring.middleware.multipart-params
   * [wrap-nested-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/nested_params.clj#L47) (ring.middleware.nested-params
   * [wrap-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/params.clj#L54) (ring.middleware.params)
   * [wrap-session](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/session.clj#L6) (ring.middleware.session)


`ring/ring-devel` middleware provides:
   * [wrap-lint](https://github.com/mmcgrana/ring/blob/master/ring-devel/src/ring/middleware/lint.clj#L84) (ring.middleware.lint)
   * [wrap-reload](https://github.com/mmcgrana/ring/blob/master/ring-devel/src/ring/middleware/reload.clj#L4) (ring.middleware.reload)
   * [wrap-stacktrace](https://github.com/mmcgrana/ring/blob/master/ring-devel/src/ring/middleware/stacktrace.clj#L75) (ring.middleware.stacktrace)


# Leiningent Templates

Templates can be used to create a project with a given set of dependencies as well as Clojure code.

There is a `compojure` template that gives you a basic running web application.  To use this template to create a new project use the following command, substituting your own project-name

```bash
lein new compojure project-name
```

This project contains ring and compojure.  The dependency for ring is `ring/site-defaults` which includes some sensible default settings for your application, eg security settings such as anti-forgery.

See the definition of [ring/site-defaults](https://github.com/ring-clojure/ring-defaults/blob/master/src/ring/middleware/defaults.clj) for further information.
