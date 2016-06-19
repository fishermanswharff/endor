# Q3 System Automation

[![Build Status][ci-image]][ci-url]

Given a log folder `/var/logs...`

* Challenge A: find all `.log` files within `/var/logs` folder (including within nested subfolders etc)
* Challenge B: output contents of every log file, using one shell liner
* Challenge C: output lines containing timestamps of form 'YYYY-MM-DD HH:MM:SS'

## Solution

```bash
# dependencies:
# ruby 2.3.0

$ bundle install # => install dependencies
$ rspec spec/automation_spec.rb # => run tests
$ rake parse_logs['path/to/log/dir'] # => rake task
$ rake parse_logs['path/to/log/dir',true] # => outputs lines with timestamps

```
Make sure the args in the rake call with timestamps do not have a space after the comma:

```bash
# Good:
rake parse_logs['path/to/log/dir',true]
# Bad:
rake parse_logs['path/to/log/dir', true]
```

[ci-image]: https://travis-ci.org/fishermanswharff/endor.svg?branch=master
[ci-url]: https://travis-ci.org/fishermanswharff/endor
