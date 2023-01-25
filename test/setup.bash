#!/usr/bin/env bash

__common_setup() {
    load '/opt/bats-support/load'
    load '/opt/bats-assert/load'

	PATH="/work/src:$PATH"
}