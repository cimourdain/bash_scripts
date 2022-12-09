# Introduction
The purpose of this repository is to store useful bash scripts.


# Features
- Terminal colors
- Logging (using above coloring script)


# Roadmap
- Add a tesing utils script

# Colors

This module stored in `colors.sh` provides a `color` function to easiy colorize text in terminal.

## Basic usage
Use the color function as follow:
```bash
source colors.sh

color "<text>" "<styles>"
```

## Coloring text (foreground color)
To color text, define foreground text color by using a style starting with `fg-`

```bash
source colors.sh

color "text in black" "fg-back"
color "text in green" "fg-green"
color "text in yellow" "fg-yellow"
color "text in blue" "fg-blue"
color "text in purple" "fg-purple"
color "text in cyan" "fg-cyan"
color "text in white" "fg-white"
```
will produce the following result:

![Basic text foreground coloring example](assets/colors_basic_fg0.png?raw=true "Basic text foreground coloring example")


## Coloring text background (background color)
To color background, define foreground text color by using a style starting with `bg-`

```bash
source colors.sh

color "text on black" "bg-back"
color "text on green" "bg-green"
color "text on yellow" "bg-yellow"
color "text on blue" "bg-blue"
color "text on purple" "bg-purple"
color "text on cyan" "bg-cyan"
color "text on white" "bg-white"
```
will produce the following result:

![Basic text background coloring example](assets/colors_basic_bg0.png?raw=true "Basic text background coloring example")

## Styling text

```bash
source colors.sh

color "normal" "normal"
color "bold" "bold"
color "low intensity" "low_intensity"
color "underline" "underline"
color "blink (not working)" "blink"
color "reverse" "reverse"
color "invisible (not working)" "invisible"
```
will produce the following result:

![Basic text styling example](assets/colors_basic_style0.png?raw=true "Basic text styling example")

## Mixing

```bash
source colors.sh

color "normal" "normal"
color "bold" "bold"
color "low intensity" "low_intensity"
color "underline" "underline"
color "blink (not working)" "blink"
color "reverse" "reverse"
color "invisible (not working)" "invisible"
```

will produce the following result:

![Basic multi styling example](assets/colors_basic_mix0.png?raw=true "Basic multi styling example")

## Advanced
By default, the coloring use `tput` if available on your system. If not found, it will use the bash escaping `\e` by default.
You can explicitely specify the colorer to use as follow:

```bash
source colors.sh

color "Use tput by default (or \e escaping if your system does not support tput)" "fg-blue"
color "Force use of \e escaping using --bash" "fg-blue --bash"
color "Force use of \033 escaping using --oct" "fg-blue --oct"
color "Force use of \x1b escaping using --hex" "fg-blue --hex"

```

will produce the following result:

![Advanced example](assets/colors_advanced0.png?raw=true "Advanced example")




# Logging

Note: as github readme cannot render text color, note that the output examples featured in the following examples are colored.

## Basic usage
```bash
source logging.sh

log warning "this is a warning"
log error "this is an error"
log critical "this is a critical"
```

will produce the following output

![Logging basic example](assets/logging_basic0.png?raw=true "Logging basic example")

### Alternatives syntaxes
#### One character
Using only the first letter of the log level will produce the same output.
```bash
source logging.sh

log w "this is a warning"
log e "this is an error"
log c "this is a critical"
```

will produce the same output as above


#### Log level index
Using only the log level index will also produce the same output.
```bash
source logging.sh

log 3 "this is a warning"
log 4 "this is an error"
log 5 "this is a critical"
```

will produce the same output as above


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

log warning "this is a warning"
log error "this is an error"
log critical "this is a critical"
log info "this is an info"
log debug "this is a debug"
log verbose "this is a verbose"
```

`$ LOG_LEVEL=verbose ./myscript.sh` will produce the following output

![Logging example setting level with env vars](assets/logging_env_var0.png?raw=true "Logging example setting level with env vars")

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
![Logging example setting level explicitly](assets/logging_explicit_level0.png?raw=true "Logging example setting level explicitly")


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

![Logging example setting prefix as env var](assets/logging_env_var_prefix0.png?raw=true "Logging example setting prefix as env var")

### Directly in code
```bash
#!/bin/bash

source ./logging.sh

log warning "this is a warning"
log error "this is a error"
log critical "this is a critical"

log_prefix 0
log warning "this is a warning"
log error "this is a error"
log critical "this is a critical"
```

`$ ./myscript.sh` will produce the following output

![Logging example setting prefix explicitly](assets/logging_explicit_prefix0.png?raw=true "Logging example setting prefix explicitly")

### Markdown styling
By appending a number after your log level, you can add syling to your logs.

#### Headers
Indexes 1 to 5 generate headers by appending # before log.

```bash
#!/bin/bash

source ./logging.sh

log info "this is a normal info"
log info1 "this is a heading 1"
log i2 "this is a heading 2"
log 23 "this is a heading 3"
log i4 "this is a heading 4"
log info5 "this is a heading 5"
```

`$ LOG_LEVEL=INFO LOG_PREFIX=0 ./myscript.sh` will produce the following output

![Logging markdown headers](assets/logging_mk_headers0.png?raw=true "Logging markdown headers")

#### Lists
Indexes 6 and 7 produce lists

```bash
#!/bin/bash

source ../logging.sh

log warning6 "item1 item2 item3"
log e7 "item1 item2 item3"
```

`$ LOG_LEVEL=INFO LOG_PREFIX=0 ./myscript.sh` will produce the following output

![Logging markdown lists](assets/logging_mk_lists0.png?raw=true "Logging markdown lists")



## Usage in scripts
In script, the following usage is recommended to prevent script to override 

Example:
```bash
#!/bin/bash
# other.sh

source ./logging.sh

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

source ./logging.sh
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

```text
enter in main script
End
```
