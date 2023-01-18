setup() {
    load '../setup.bash'
    __common_setup
}

@test "default log prefix -- contains date and error level" {
    log_date=$(date +"%Y-%m-%dT%H:%M:")
    source logging.sh

    run log critical "this is a critical"
    assert_line --partial "$log_date"
    assert_line --partial '[CRITICAL]this is a critical'
}

@test "LOG_PREFIX disabled by env var -- not contains date and error level" {
    log_date=$(date +"%Y-%m-%dT%H:%M:")
    LOG_PREFIX=0
    source logging.sh

    run log critical "this is a critical"
    refute_output --partial "$log_date"
    refute_output --partial '[CRITICAL]'
}

@test "log prefix disabled explicitely -- not contains date and error level" {
    log_date=$(date +"%Y-%m-%dT%H:%M:")

    source logging.sh
    log_prefix 0

    run log critical "this is a critical"
    refute_output --partial "$log_date"
    refute_output --partial '[CRITICAL]'
}
