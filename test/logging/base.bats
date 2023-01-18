#!/usr/bin/env bats

setup() {
    load '../setup.bash'
    __common_setup
    source logging.sh
}

@test "logging does not output errors" {
	log critical "this is a critical"
    assert_success
    log error "this is an error"
    assert_success
    log warning "this is a warning"
    assert_success
  	log info "this is an info"
    assert_success
    log debug "this is a debug"
    assert_success
    log verbose "this is a verbose"
    assert_success
}

