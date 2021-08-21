# Middleware
Apply common transformations to request and or response hash-maps, such as security tokens, cookie management, session and access management, presentation templates, etc.

Middleware is implemented by Clojure functions that receive a handler as an argument and return a handler as a result.


# Middleware in Ring
Middleware can wrap handlers or other middleware, affecting their behavior.

For example the `wrap-reload` middleware enables live reloading by detecting file changes and reloading affected functions into their namespace, before the request is passed to the relevant handler function

Middleware provided by Ring includes:

* In `ring/ring-core`:
   * [wrap-cookies](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/cookies.clj#L124) (ring.middleware.cookies)
   * [wrap-file](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/file.clj#L14) (ring.middleware.file)
   * [wrap-file-info](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/file_info.clj#L89) (ring.middleware.file-info)
   * [wrap-flash](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/flash.clj#L4) (ring.middleware.flash)
   * [wrap-keyword-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/keyword_params.clj#L15) (ring.middleware.keyword-params)
   * [wrap-multipart-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/multipart_params.clj#L60) (ring.middleware.multipart-params
   * [wrap-nested-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/nested_params.clj#L47) (ring.middleware.nested-params
   * [wrap-params](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/params.clj#L54) (ring.middleware.params)
   * [wrap-session](https://github.com/mmcgrana/ring/blob/master/ring-core/src/ring/middleware/session.clj#L6) (ring.middleware.session)
* In `ring/ring-devel`:
   * [wrap-lint](https://github.com/mmcgrana/ring/blob/master/ring-devel/src/ring/middleware/lint.clj#L84) (ring.middleware.lint)
   * [wrap-reload](https://github.com/mmcgrana/ring/blob/master/ring-devel/src/ring/middleware/reload.clj#L4) (ring.middleware.reload)
   * [wrap-stacktrace](https://github.com/mmcgrana/ring/blob/master/ring-devel/src/ring/middleware/stacktrace.clj#L75) (ring.middleware.stacktrace)

<!-- TODO: check list of middleware and prioritize or group, making them easier to understand. -->
