#!/usr/bin/env bats

setup() {
    load '../setup.bash'
    __common_setup
    source logging.sh
}


@test "default log level is warning" {
    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    refute_output 'this is an info'
    
    run log debug "this is a debug"
    refute_output 'this is a debug'

    run log verbose "this is a verbose"
    refute_output 'this is a verbose'
}

@test "set log level w/ env var -- critical" {
    LOG_LEVEL=CRITICAL
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    refute_output --partial 'this is an error'

    run log warning "this is a warning"
    refute_output --partial 'this is a warning'

  	run log info "this is an info"
    refute_output --partial 'this is an info'
    
    run log debug "this is a debug"
    refute_output --partial 'this is a debug'

    run log verbose "this is a verbose"
    refute_output --partial 'this is a verbose'
}

@test "set log level w/ env var -- error" {
    LOG_LEVEL=ERROR
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    refute_output --partial 'this is a warning'

  	run log info "this is an info"
    refute_output --partial 'this is an info'
    
    run log debug "this is a debug"
    refute_output --partial 'this is a debug'

    run log verbose "this is a verbose"
    refute_output --partial 'this is a verbose'
}

@test "set log level w/ env var -- warning" {
    LOG_LEVEL=WARNING
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    refute_output --partial 'this is an info'
    
    run log debug "this is a debug"
    refute_output --partial 'this is a debug'

    run log verbose "this is a verbose"
    refute_output --partial 'this is a verbose'
}

@test "set log level w/ env var -- info" {
    LOG_LEVEL=INFO
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    assert_line --partial "this is an info"
    
    run log debug "this is a debug"
    refute_output --partial 'this is a debug'

    run log verbose "this is a verbose"
    refute_output --partial 'this is a verbose'
}

@test "set log level w/ env var -- debug" {
    LOG_LEVEL=DEBUG
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    assert_line --partial "this is an info"
    
    run log debug "this is a debug"
    assert_line --partial "this is a debug"

    run log verbose "this is a verbose"
    refute_output --partial 'this is a verbose'
}

@test "set log level w/ env var -- verbose" {
    LOG_LEVEL=VERBOSE
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    assert_line --partial "this is an info"
    
    run log debug "this is a debug"
    assert_line --partial "this is a debug"

    run log verbose "this is a verbose"
    assert_line --partial 'this is a verbose'
}

@test "set log level explicitely -- critical" {
    source logging.sh

    log_level critical

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    refute_output --partial 'this is an error'
}

@test "set log level explicitely -- error" {
    source logging.sh
    log_level error

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    refute_output --partial 'this is a warning'
}

@test "set log level explicitely -- warning" {
    source logging.sh
    log_level warning

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    refute_output --partial 'this is an info'
}

@test "set log level explicitely -- info" {
    source logging.sh
    log_level info

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    assert_line --partial "this is an info"
    
    run log debug "this is a debug"
    refute_output --partial 'this is a debug'
}

@test "set log level explicitely -- debug" {
    source logging.sh
    log_level debug

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    assert_line --partial "this is an info"
    
    run log debug "this is a debug"
    assert_line --partial "this is a debug"

    run log verbose "this is a verbose"
    refute_output --partial 'this is a verbose'
}

@test "set log level explicitely -- verbose" {
    source logging.sh
    log_level verbose

    run log critical "this is a critical"
    assert_line --partial 'this is a critical'
    
    run log error "this is an error"
    assert_line --partial 'this is an error'

    run log warning "this is a warning"
    assert_line --partial 'this is a warning'

  	run log info "this is an info"
    assert_line --partial "this is an info"
    
    run log debug "this is a debug"
    assert_line --partial "this is a debug"

    run log verbose "this is a verbose"
    assert_line --partial 'this is a verbose'
}


@test "explicitely set global log_level and restore" {
    source logging.sh
    log_level_global info

    log_off
    run log info "info not displayed bc log is off"
    refute_output --partial "info not displayed bc log is off"

    run log debug "debug not diplayed bc log is off"
    refute_output --partial "debug not diplayed bc log is off"

    log_on  # restore to global log level (info)
    run log info "info displayed bc log is restored"
    assert_line --partial "info displayed bc log is restored"
    
    run log debug "debug not displayed bc log is restored to info"
    refute_output --partial "debug not displayed bc log is restored to info"
}
