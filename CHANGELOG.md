## 2.0.7
  - Docs: Set the default_codec doc attribute.

## 2.0.6
 - Docs: Add documentation template
## 2.0.4
 - Add encoding: utf-8 line to spec file.  This can prevent issues with tests.
## 2.0.1
 - Simplify the shutdown implementation a bit for easier understanding
## 2.0.0
 - Plugins were updated to follow the new shutdown semantic, this mainly allows Logstash to instruct input plugins to terminate gracefully, 
   instead of using Thread.raise on the plugins' threads. Ref: https://github.com/elastic/logstash/pull/3895
 - Dependency on logstash-core update to 2.0

