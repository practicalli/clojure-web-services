# Java System properties
System properties can be set on the Java command line using the `-Dpropertyname=value` syntax. They can also be added at Clojure runtime using `(System/getProperties)` will return a Properties object with the system properties for the current REPL.

`java.runtime.version=11` will set the version of Java used in Cloud application platforms.

Example output on an Ubuntu Linux operating system running Java 11 and Spacemacs with CIDER.

```
  "sun.desktop" = "gnome"
  "awt.toolkit" = "sun.awt.X11.XToolkit"
  "java.specification.version" = "11"
  "sun.cpu.isalist" = ""
  "sun.jnu.encoding" = "UTF-8"
  "java.class.path" = "src:resources:/home/practicalli/.m2/repository/org/clojure/clojure/1.10.1/clojure-1.10.1.jar:/home/practicalli/.m2/repository/joda-time/joda-time/2...
  "java.vm.vendor" = "Ubuntu"
  "sun.arch.data.model" = "64"
  "sun.font.fontmanager" = "sun.awt.X11FontManager"
  "java.vendor.url" = "https://ubuntu.com/"
  "user.timezone" = "Europe/London"
  "os.name" = "Linux"
  "java.vm.specification.version" = "11"
  "sun.java.launcher" = "SUN_STANDARD"
  "user.country" = "US"
  "sun.boot.library.path" = "/usr/lib/jvm/java-11-openjdk-amd64/lib"
  "sun.java.command" = "clojure.main -m nrepl.cmdline --middleware [\"refactor-nrepl.middleware/wrap-refactor\", \"cider.nrepl/cider-middleware\"]"
  "jdk.debug" = "release"
  "sun.cpu.endian" = "little"
  "user.home" = "/home/practicalli"
  "user.language" = "en"
  "java.specification.vendor" = "Oracle Corporation"
  "clojure.libfile" = ".cpcache/4064833315.libs"
  "java.version.date" = "2020-04-14"
  "java.home" = "/usr/lib/jvm/java-11-openjdk-amd64"
  "file.separator" = "/"
  "java.vm.compressedOopsMode" = "Zero based"
  "line.separator" = "\n"
  "java.specification.name" = "Java Platform API Specification"
  "java.vm.specification.vendor" = "Oracle Corporation"
  "java.awt.graphicsenv" = "sun.awt.X11GraphicsEnvironment"
  "sun.management.compiler" = "HotSpot 64-Bit Tiered Compilers"
  "java.runtime.version" = "11.0.7+10-post-Ubuntu-3ubuntu1"
  "user.name" = "practicalli"
  "path.separator" = ":"
  "os.version" = "5.4.0-40-generic"
  "java.runtime.name" = "OpenJDK Runtime Environment"
  "file.encoding" = "UTF-8"
  "java.vm.name" = "OpenJDK 64-Bit Server VM"
  "java.vendor.url.bug" = "https://bugs.launchpad.net/ubuntu/+source/openjdk-lts"
  "java.io.tmpdir" = "/tmp"
  "java.version" = "11.0.7"
  "user.dir" = "/home/practicalli/projects/clojure/database-access/banking-on-clojure-webapp"
  "os.arch" = "amd64"
  "java.vm.specification.name" = "Java Virtual Machine Specification"
  "java.awt.printerjob" = "sun.print.PSPrinterJob"
  "sun.os.patch.level" = "unknown"
  "java.library.path" = "/usr/java/packages/lib:/usr/lib/x86_64-linux-gnu/jni:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/lib/jni:/lib:/usr/lib"
  "java.vendor" = "Ubuntu"
  "java.vm.info" = "mixed mode, sharing"
  "java.vm.version" = "11.0.7+10-post-Ubuntu-3ubuntu1"
  "sun.io.unicode.encoding" = "UnicodeLittle"
  "apple.awt.UIElement" = "true"
  "java.class.version" = "55.0"
```


| Java Runtime properties | Description                                                                                        |
|-------------------------|----------------------------------------------------------------------------------------------------|
| java.home               | JRE home directory                                                                                 |
| java.library.path       | JRE library search path for search native libraries (usually taken from PATH environment variable) |
| java.class.path         | JRE classpath e.g., '.' (dot – used for current working directory).                                |
| java.ext.dirs           | JRE extension library path(s)                                                                      |
| java.version            | JDK version
| java.runtime.version    | JRE version

| File system properties | Description                                                                                        |
|------------------------|----------------------------------------------------------------------------------------------------|
| file.separator         | symbol for file directory separator ('/' for Unix or '\' for windows)                              |
| path.separator         | symbol for separating path entries in PATH or CLASSPATH. (':' for Unix or ';' for windows)         |
| line.separator         | symbol for end-of-line / new line ("\n" for Unix or "\r\n" for windows) or /Mac OS X. |

| User system properties | Description                          |
|------------------------|--------------------------------------|
| user.name              | the user’s name.                     |
| user.home              | the user’s home directory.           |
| user.dir               | the user’s current working directory |

| Operating System properties | Description                   |
|-----------------------------|-------------------------------|
| os.name                     | operating System name         |
| os.version                  | operating System version      |
| os.arch                     | operating System architecture |
