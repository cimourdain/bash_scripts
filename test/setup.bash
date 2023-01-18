#!/usr/bin/env bash

__common_setup() {
    load '/opt/bats-support/load'
    load '/opt/bats-assert/load'

	PATH="/work/src:$PATH"
}

# @test "can run our script" {
# 	source logging.sh
#   	assert_equal "$(log warning 'coucou')" "toto"
#   	assert [ "$r" -eq 'coucou1' ]
#   	assert_output "coucou2"
# }

# @test "can run our script 2" {
# 	colors.sh
# }

# @test "addition using bc" {
# 	result="$(echo 2+2 | bc)"
# 	[ "$result" -eq 4 ]
# }

# @test "addition using dc" {
# 	result="$(echo 2 2+p | dc)"
# 	assert_equal "$result" 4
# }
