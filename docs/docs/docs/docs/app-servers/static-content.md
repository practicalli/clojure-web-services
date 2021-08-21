# Static Content


> #### Hint::Avoid serving large or complex static content
> The most efficient and secure way of serving static content from a Clojure (or any other app) is to not server content directly.  Using a static web server such as nginx or apache httpd provides a separation of concerns.
>
> Nginx and Apache Httpd provide many features for serving static content and managing mime types, etc which would have little value to implement inside a Clojure web application.
>
> Nginx and Apache Httpd can be configured as a reverse proxy, only redirecting specific request to the Clojure application
