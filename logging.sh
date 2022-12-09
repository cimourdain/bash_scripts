#!/bin/bash

#####################################################################
##
## title: Bash Logging script
##
## description: Simple bash logging with formatting options (colors, prefix, current path, markdown rendering etc.)
##
## Usage:
##   basic usage:
##    log <level>[<sublevel>] <message>
##    levels can be:
##      - full text: critical, error, warning, info, debug, verbose
##      - short: c, e, w, i, d, v
##      - number: 5, 4, 3, 2, 1, 0
##    sublevels optionally be contatenated to level:
##      - 1: markdown heading 1 (=prepend #)
##      - 2: markdown heading 1 (=prepend ##)
##      - 3: markdown heading 1 (=prepend ###)
##      - 4: markdown heading 1 (=prepend ####)
##      - 5: markdown heading 1 (=prepend #####)
##      - 6: unordered list idem (=prepend \t -)
##      - 7: unordered list idem (=prepend \t %n)
##    Setting log level:
##       by env var : LOG_LEVEL=<level>
##       explicitly in code: log_level <level>
##    Setting log prefix:
##       by env var : LOG_PREFIX=<0/1>
##       explicitly in code: log_prefix <0/1>
##  Other provided functions:
##      log_on: enable logging
##      log_off: completely disable logging
##
## license: MIT
##
#####################################################################

##################
# GLOBAL VARS
##################
declare -A DEFAULT_LOGGER_STATE=([DEFAULT_LOG_LEVEL]=${LOG_LEVEL:-"WARNING"} [LOG_LEVEL]=${LOG_LEVEL:-"WARNING"} [DEFAULT_LOG_PREFIX]="1" [LOG_PREFIX]=${LOG_PREFIX:-"1"})
if [ -z "${LOGGER_STATE+x}" ]; then
  declare -A LOGGER_STATE
  for key in "${!DEFAULT_LOGGER_STATE[@]}"; do
    LOGGER_STATE[$key]=${DEFAULT_LOGGER_STATE[$key]}
  done
fi
declare -A LOG_COLORS=([5]="\e[41m" [4]="\e[91m" [3]="\e[0;93m" [2]="\e[0;34m" [1]="\e[0;36m" [0]="\e[0;37m" )


##################
# PRIVATE FUNC
##################
function __resolve_log_level_subidx(){
  local level_name level_idx
  level_name="${1}"
  level_idx="${level_name: -1}"

  if [[ ${#level_name} == 1 || ! "$level_idx" =~ ^[0-9]+$ ]]; then
      level_idx="0"
  fi
  echo "${level_idx}"
}

function __resolve_log_level(){
  local level_name level_name_str level_idx log_level_subidx
  level_name="${1^^}"
  log_level_subidx="$(__resolve_log_level_subidx "${level_name}")"

  case "${level_name}" in
      SILENT* | S* | 6* )
          level_name_str="SILENT"
          level_idx="6"
          ;;
      CRITICAL* | C* | 5* )
          level_name_str="CRITICAL"
          level_idx="5"
          ;;
      ERROR* | E* | 4* )
          level_name_str="ERROR"
          level_idx="4"
          ;;
      WARNING* | W* | 3* )
          level_name_str="WARNING"
          level_idx="3"
          ;;
      INFO* | I* | 2*)
          level_name_str="INFO"
          level_idx="2"
           ;;
      DEBUG* | D* | 1*)
          level_name_str="DEBUG"
          level_idx="1"
          ;;
      *)
        level_name_str="VERBOSE"
        level_idx="0"
      ;;
  esac
  echo "${level_name_str} ${level_idx} ${log_level_subidx}"
}


function __reverse_arr(){
    local input_array reversed
    input_array=
    reversed=()
    local i;
    for ((i=${#input_array[@]};i>0;i--))
        do reversed+=("${!i}")
    done;
    echo
}

function __log_fn_trail() {
    local i functions_trail_array functions_trail_reversed functions_trail_reversed_str

    # load functions trail as a array
    IFS=' ' read -r -a functions_trail_array <<< ${FUNCNAME[*]:2}

    # reverese array for readability
    functions_trail_reversed=()
    for i in "${functions_trail_array[@]}"; do
        functions_trail_reversed=(${i} "${functions_trail_reversed[@]}")
    done

    functions_trail_reversed_str="${functions_trail_reversed[*]}"
    functions_trail_reversed_str=${functions_trail_reversed_str//" "/">"}
    echo "${functions_trail_reversed_str}"
}

function __print_log_line() {
  local message=${1}
  local line_format=${2:-"%s\n"}
  printf "${line_format}" "${message}"
}

function __format_log() {
  local log_level_idx message prefix
  local color_start color_end
  message=${1}
  log_level_idx=${2}
  log_level_subidx="${3}"
  prefix="${4}"

  color_start="${LOG_COLORS[${log_level_idx}]}"
  color_end="$(echo -en "\e[00m")"
  prefix="$(echo -en "${color_start}")${prefix}"

  # echo "log level: ${log_level_idx}-${log_level_subidx}} => ${prefix}"
  case "${log_level_subidx}" in
      1)
        message="# ${message}"
        __print_log_line "${prefix}${message}${color_end}"
        ;;
      2)
        message="## ${message}"
        __print_log_line "${prefix}${message}${color_end}"
        ;;
      3)
        message="### ${message}"
        __print_log_line "${prefix}${message}${color_end}"
        ;;
      4)
        message="##### ${message}"
        __print_log_line "${prefix}${message}${color_end}"
        ;;
      5)
        message="###### ${message}"
        __print_log_line "${prefix}${message}${color_end}"
        ;;
      6)
        __print_log_line "${prefix}" "%s"
        local message_array=(${message})
        for item in "${message_array[@]}"; do
            __print_log_line "${item}" "\t- %s\n"
        done
        __print_log_line "${color_end}"
        ;;
      7)
        __print_log_line "${prefix}" "%s"
        local message_array=(${message})
        local i=0
        for item in "${message_array[@]}"; do
            __print_log_line "${i}.${item}" "\t%s\n"
            i=$((i+1))
        done
        __print_log_line "${color_end}"
        ;;
      *)
        __print_log_line "${prefix}${message}${color_end}"
      ;;
  esac
}

##################
# PUBLIC FUNC
##################
function log() {
  local message
  local log_level_array log_level_str log_level_idx log_level_subidx
  local current_global_log_level_array current_global_log_level_idx # current_global_log_level_str
  local functions_trail log_date log_files_trail
  local prefix

  message=${2}

  # identify log level
  read -a log_level_array <<< "$(__resolve_log_level "${1}")"
  # echo "log: ${log_level_array[0]} & ${log_level_array[1]}"
  log_level_str=${log_level_array[0]}
  log_level_idx=${log_level_array[1]}
  log_level_subidx=${log_level_array[2]}

  # identify global log level
  read -a current_global_log_level_array <<< "$(__resolve_log_level "${LOGGER_STATE[LOG_LEVEL]}")"
  # echo "global: ${current_global_log_level_array[0]} & ${current_global_log_level_array[1]}"
  # current_global_log_level_str=${current_global_log_level_array[0]}
  current_global_log_level_idx=${current_global_log_level_array[1]}

  # function trail and files
  functions_trail=$(__log_fn_trail)

  current_script_file="${0##*/}"
  log_script_file="${BASH_SOURCE##*/}"
  if [[ $current_script_file == $log_script_file ]]; then
    log_files_trail=$current_script_file
  else
    log_files_trail="$current_script_file>$log_script_file"
  fi

  # log date
  log_date=$(date +"%Y-%m-%dT%H:%M:%S%:z")

  if [[ ! $current_global_log_level_idx > $log_level_idx ]];then
    prefix=""
    if [[ ${LOGGER_STATE[LOG_PREFIX]} == "1" ]];then
       prefix="${log_date}-${log_files_trail}-${functions_trail}-[${log_level_str}]"
    fi
    __format_log "${message}" "${log_level_idx}" "${log_level_subidx}" "${prefix}"
  fi
}

function log_off {
    LOGGER_STATE[LOG_LEVEL]="SILENT"
}

function log_level {
  local log_level_str
  read -a log_level_array <<< "$(__resolve_log_level "${1}")"
  log_level_str=${log_level_array[0]}
  LOGGER_STATE[LOG_LEVEL]="$log_level_str"
}

function log_on {
    LOGGER_STATE[LOG_LEVEL]=${LOGGER_STATE[DEFAULT_LOG_LEVEL]}
}

function log_prefix {
    LOGGER_STATE[LOG_PREFIX]="${1}"
}

function log_level_safe() {
  local func_log_level=${1}
  local func_log_prefix=${2}

  local origin_log_level="${LOGGER_STATE[LOG_LEVEL]}"
  if [[ ${origin_log_level} == ${LOGGER_STATE[DEFAULT_LOG_LEVEL]} ]];then
       log_level "${func_log_level}"
  fi
  local origin_log_prefix="${LOGGER_STATE[LOG_PREFIX]}"
   if [[ ${origin_log_prefix} == ${LOGGER_STATE[DEFAULT_LOG_PREFIX]} ]];then
     log_prefix ${func_log_prefix}
   fi

   echo "${origin_log_level} ${origin_log_prefix}"
}

function log_level_restore() {
  local func_log_level=${1}
  local func_log_prefix=${2}
  log_level "${func_log_level}"
  log_prefix ${func_log_prefix}
}

###################
## SAMPLES/TESTS
###################
#echo "Default logging level ${LOGGER_STATE[DEFAULT_LOG_LEVEL]}"
#echo "Current logging level ${LOGGER_STATE[LOG_LEVEL]}"
#
#echo "explicitely set level to verbose (prefer usage of env variable LOG_LEVEL to apply on all your script)"
#LOGGER_STATE[LOG_LEVEL]=verbose
## Basic usage
### using full text log level name
#log verbose "Verbose message"
#log debug "debug message"
#log info "Info message"
#log warning "Warning message"
#log error "Error message"
#log critical "Critical message"
#
### using abbreviated text level name
#log v "Function Verbose message"
#log d "Function debug message"
#log i "Function Info message"
#log w "Function Warning message"
#log e "Function Error message"
#log c "Function Critical message"
#
### Using level index
#log 0 "Nested Verbose message"
#log 1 "Nested debug message"
#log 2 "Nested Info message"
#log 3 "Nested Warning message"
#log 4 "Nested Error message"
#log 5 "Nested Critical message"
#
## Setting log level (default log level is INFO)
### Using in functions (to test functions trail)
#echo "WARNING logging for the following section"
#log_level warning  # set logging to warning for the following commands
#log verbose "Verbose message"
#log debug "debug message"
#log info "Info message"
#log warning "Warning message"
#log error "Error message"
#log critical "Critical message"
#echo "reset to global level"
#log_on  # reset logging to previous level
#
### Disable completely
#echo "No logging for the following section"
#log_off # disable all logging for the following section
#log verbose "Verbose message"
#log debug "debug message"
#log info "Info message"
#log warning "Warning message"
#log error "Error message"
#log critical "Critical message"
#echo "reset logging to global level"
#log_on  # reset logging to previous level
#
# # Log Formatting
#echo "The following section uses a sub index to determine the log formatting"
### Headers title
#echo "using full text"
#log info1 "Header 1 (info1 => info=log level info, 1=header of type 1)"
#echo "using abbreviated text"
#log w2 "Header 2  (w2 => w=log level warning, 2=header of type 2)"
#echo "using index"
#log 43 "Header 3 (e3 => 4=log level error, 3=header of type 3)"
#echo "titles goes up to 5"
#log c5 "Header (c5 => c=log level critical, 1=header of type 5)"
#
### Lists
#echo "sub index of value 6 are un-numbered lists"
#log info6 "car truck bike"
#echo "sub index of value 7 are numbered lists"
#log w7 "keys phone cards"
#
## Logs details in prefix
#echo "activate prefix on logs (prefer usage of env var LOG_PREFIX=1)"
#LOGGER_STATE[LOG_PREFIX]=1
### Using in functions (to test functions trail)
#function nested_logs() {
#    # use log index to specify log message level
#    log 0 "Nested Verbose message"
#    log 1 "Nested debug message"
#    log 2 "Nested Info message"
#    log 3 "Nested Warning message"
#    log 4 "Nested Error message"
#    log 5 "Nested Critical message"
#}
#
#function test_logs() {
#    # use one letter level
#    log v "Function Verbose message"
#    log d "Function debug message"
#    log i "Function Info message"
#    log w "Function Warning message"
#    log e "Function Error message"
#    log c "Function Critical message"
#    nested_logs
#}
#
#test_logs
#
#
## Using in scripts
#```bash
#source ./logging.sh
#
#
#function my_func() {
#  # prefer to use this function to prevent overrides by upper functions
#  local origin_log_settings
#  read -a origin_log_settings <<< "$(log_level_safe "info" "0")"
#  log d "debug message"
#  # restore log levels to settings of upper function
#  log_level_restore "${origin_log_settings[0]}" "${origin_log_settings[1]}"
#}
#```
