#!/usr/bin/env bats

setup() {
    load '../setup.bash'
    __common_setup
    source colors.sh
}


@test "color with no errors" {
	color "hello"
    assert_success

    color "hello" "fg-blue"
    assert_success

    color "hello" "fg-blue undefined"
    assert_success

    color "hello" "fg-blue bg-red underline"
    assert_success
}

