# Logging

Note: as github readme cannot render text color, note that the output examples featured in the following examples are colored.

## Basic usage
```bash
source logging.sh

log warning "this is a warning
log error "this is an error"
log critical "this is a critical"
```

will produce the following output

<p>
<span style="color:yellow">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[WARNING]this is a warning</span><br/>
<span style="color:red">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[ERROR]this is an error</span><br/>
<span style="background-color:red;color:white">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[CRITICAL]this is a critical</span>
</p>


### Alternatives syntaxes
#### One character
Using only the first letter of the log level will produce the same output.
```bash
source logging.sh

log w "this is a warning
log e "this is an error"
log c "this is a critical"
```

will produce the following output

<p>
<span style="color:yellow">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[WARNING]this is a warning</span><br/>
<span style="color:red">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[ERROR]this is an error</span><br/>
<span style="background-color:red;color:white">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[CRITICAL]this is a critical</span>
</p>

#### Log level index
Using only the log level index will also produce the same output.
```bash
source logging.sh

log 3 "this is a warning
log 4 "this is an error"
log 5 "this is a critical"
```

will produce the following output

<p>
<span style="color:yellow">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[WARNING]this is a warning</span><br/>
<span style="color:red">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[ERROR]this is an error</span><br/>
<span style="background-color:red;color:white">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[CRITICAL]this is a critical</span>
</p>


## Log levels
The following log levels are availables:
- critical / c / 5
- error / e / 4
- warning / w / 3
- info / i / 2
- debug / d / 1
- verbose / v / 0

By default, the log level is set to WARNING.

### Set the log level with environment variable
```bash
source logging.sh

log warning "this is a warning
log error "this is an error"
log critical "this is a critical"
log info "this is an info"
log debug "this is a debug"
log verbose "this is a verbose"
```

`$ LOG_LEVEL=verbose ./myscript.sh` will produce the following output

<p>
<span style="color:yellow">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[WARNING]this is a warning</span><br/>
<span style="color:red">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[ERROR]this is an error</span><br/>
<span style="background-color:red;color:white">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[CRITICAL]this is a critical</span><br />
<span style="color:blue">2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[INFO]this is an info</span><br />
<span style="color:cyan">2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[DEBUG]this is a debug</span><br />
<span>2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[VERBOSE]this is a verbose</span><br />
</p>

### Update the log level in the code
You can also use logging function to update the log level in your code, for example
```bash
source logging.sh

# will not be printed (because log level is set to warning in default)
log info "hidden info"
log debug "hidden debug"
log verbose "hidden verbose"

# explicitely set log level to verbose for the following section
log_level verbose
log info "this is an info"
log debug "this is a debug"
log verbose "this is a verbose"

# explicitely set log level to info for the following section
log_level info
log info "this is an info"
log debug "hidden debug"
log verbose "hidden verbose"

# disable all logs
log_off
log critical "hidden critical"
log error "hidden error"
log warning "hidden warning"
log info "hidden info"
log debug "hidden debug"
log verbose "hidden verbose"

# reset log level to default (WARNING)
log_on
log info "hidden info"
log debug "hidden debug"
log verbose "hidden verbose"
```
<p>
<span style="color:blue">2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[INFO]this is an info</span><br />
<span style="color:cyan">2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[DEBUG]this is a debug</span><br />
<span>2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[VERBOSE]this is a verbose</span><br />
<span style="color:blue">2022-11-25T16:37:59+01:00-logging-0.sh>logging.sh-main-[INFO]this is an info</span><br />
</p>


## Styling your logs
### Toggle the prefix data
#### With environment variable

```bash
source logging.sh

log warning "this is a warning"
log error "this is a error"
log critical "this is a critical"
```

`$ LOG_PREFIX=0 ./myscript.sh` will produce the following output

<p>
<span style="color:yellow">this is a warning</span><br/>
<span style="color:red">this is an error</span><br/>
<span style="background-color:red;color:white">this is a critical</span>
</p>

### Directly in code
```bash
#!/bin/bash

source ../logging.sh

log warning "this is a warning"
log error "this is a error"
log critical "this is a critical"

log_prefix 0
log warning "this is a warning"
log error "this is a error"
log critical "this is a critical"
```

`$ ./myscript.sh` will produce the following output

<p>
<span style="color:yellow">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[WARNING]this is a warning</span><br/>
<span style="color:red">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[ERROR]this is an error</span><br/>
<span style="background-color:red;color:white">2022-11-25T16:23:42+01:00-logging-0.sh>logging.sh-main-[CRITICAL]this is a critical</span><br />
<span style="color:yellow">this is a warning</span><br/>
<span style="color:red">this is an error</span><br/>
<span style="background-color:red;color:white">this is a critical</span>
</p>

### Markdown styling
By appending a number after your log level, you can add syling to your logs.

#### Headers
Indexes 1 to 5 generate headers by appending # before log.

```bash
#!/bin/bash

source ../logging.sh

log info "this is a normal info"
log info1 "this is a heading 1"
log i2 "this is a heading 2"
log 23 "this is a heading 3"
log i4 "this is a heading 4"
log info5 "this is a heading 5"
```

`$ LOG_LEVEL=INFO LOG_PREFIX=0 ./myscript.sh` will produce the following output

<p style="color:blue">
this is a normal info<br/>
# this is a heading 1<br/>
## this is a heading 2<br/>
### this is a heading 3<br/>
##### this is a heading 4<br/>
###### this is a heading 5<br/>
</p>

#### Lists
Indexes 6 and 7 produce lists

```bash
#!/bin/bash

source ../logging.sh

log warning6 "item1 item2 item3"
log e7 "item1 item2 item3"
```

`$ LOG_LEVEL=INFO LOG_PREFIX=0 ./myscript.sh` will produce the following output

<ul style="color:yellow">
  <li>item1</li>
  <li>item2</li>
  <li>item3</li>
</ul>

<ol style="color:red">
  <li>item1</li>
  <li>item2</li>
  <li>item3</li>
</ol>


## Usage in scripts
In script, the following usage is recommended to prevent script to override 

Example:
```bash
#!/bin/bash
# other.sh

source ../logging.sh

function my_func(){
    local origin_log_level="${LOGGER_STATE[LOG_LEVEL]}"
    local origin_log_prefix="${LOGGER_STATE[LOG_PREFIX]}"
    log_level_safe "info" "0"

    log i "info message only printed when my_func is called directly"

    # restore log levels to settings of upper function
    log_level_restore "${origin_log_level}" "${origin_log_prefix}"
}
```

```bash
#!/bin/bash
# myscript.sh

source ../logging.sh
source ./other.sh

log_level info
log i "enter in main script"
log_off
my_func
log_on
log i "Not printed because log_on reset to default (ERROR from env var)"
log_level i
log i "End"
```

calling `$ LOG_LEVEL=ERROR LOG_PREFIX=0 ./myscript.sh` the result will be the following:

<p style="color:blue">
enter in main script<br />
End
</p>
