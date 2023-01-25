#!/usr/bin/env bats

setup() {
    load '../setup.bash'
    __common_setup
    source colors.sh
}

@test "color default" {
    source colors.sh
    assert_equal $(color "coucou" | cat -v) "coucou^[(B^[[m"
    assert_equal $(color "coucou" "--bash" | cat -v) "coucou"
    assert_equal $(color "coucou" "--oct" | cat -v) "coucou"
    assert_equal $(color "coucou" "--hex" | cat -v) "coucou"
}


@test "color foreground --default" {
    source colors.sh

    assert_equal $(color "coucou" "fg-black" | cat -v) "^[[30mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-red" | cat -v) "^[[3124mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-green" | cat -v) "^[[364mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-yellow" | cat -v) "^[[3136mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-blue" | cat -v) "^[[333mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-purple" | cat -v) "^[[3125mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-cyan" | cat -v) "^[[337mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "fg-white" | cat -v) "^[[315mcoucou^[(B^[[m"
}

@test "color foreground --bash" {
    source colors.sh

    assert_equal $(color "coucou" "fg-black --bash" | cat -v) "^[[0;30mcoucou^[[m"
    assert_equal $(color "coucou" "fg-red --bash" | cat -v) "^[[0;31mcoucou^[[m"
    assert_equal $(color "coucou" "fg-green --bash" | cat -v) "^[[0;32mcoucou^[[m"
    assert_equal $(color "coucou" "fg-yellow --bash" | cat -v) "^[[0;33mcoucou^[[m"
    assert_equal $(color "coucou" "fg-blue --bash" | cat -v) "^[[0;34mcoucou^[[m"
    assert_equal $(color "coucou" "fg-purple --bash" | cat -v) "^[[0;35mcoucou^[[m"
    assert_equal $(color "coucou" "fg-cyan --bash" | cat -v) "^[[0;36mcoucou^[[m"
    assert_equal $(color "coucou" "fg-white --bash" | cat -v) "^[[0;37mcoucou^[[m"
}

@test "color foreground --hex" {
    source colors.sh

    assert_equal $(color "coucou" "fg-black --hex" | cat -v) "^[[0;30mcoucou^[[m"
    assert_equal $(color "coucou" "fg-red --hex" | cat -v) "^[[0;31mcoucou^[[m"
    assert_equal $(color "coucou" "fg-green --hex" | cat -v) "^[[0;32mcoucou^[[m"
    assert_equal $(color "coucou" "fg-yellow --hex" | cat -v) "^[[0;33mcoucou^[[m"
    assert_equal $(color "coucou" "fg-blue --hex" | cat -v) "^[[0;34mcoucou^[[m"
    assert_equal $(color "coucou" "fg-purple --hex" | cat -v) "^[[0;35mcoucou^[[m"
    assert_equal $(color "coucou" "fg-cyan --hex" | cat -v) "^[[0;36mcoucou^[[m"
    assert_equal $(color "coucou" "fg-white --hex" | cat -v) "^[[0;37mcoucou^[[m"
}

@test "color foreground --oct" {
    source colors.sh

    assert_equal $(color "coucou" "fg-black --oct" | cat -v) "^[[0;30mcoucou^[[m"
    assert_equal $(color "coucou" "fg-red --oct" | cat -v) "^[[0;31mcoucou^[[m"
    assert_equal $(color "coucou" "fg-green --oct" | cat -v) "^[[0;32mcoucou^[[m"
    assert_equal $(color "coucou" "fg-yellow --oct" | cat -v) "^[[0;33mcoucou^[[m"
    assert_equal $(color "coucou" "fg-blue --oct" | cat -v) "^[[0;34mcoucou^[[m"
    assert_equal $(color "coucou" "fg-purple --oct" | cat -v) "^[[0;35mcoucou^[[m"
    assert_equal $(color "coucou" "fg-cyan --oct" | cat -v) "^[[0;36mcoucou^[[m"
    assert_equal $(color "coucou" "fg-white --oct" | cat -v) "^[[0;37mcoucou^[[m"
}

@test "color background --default" {
    source colors.sh

    assert_equal $(color "coucou" "bg-black" | cat -v) "^[[40mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-red" | cat -v) "^[[4124mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-green" | cat -v) "^[[464mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-yellow" | cat -v) "^[[4136mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-blue" | cat -v) "^[[433mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-purple" | cat -v) "^[[4125mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-cyan" | cat -v) "^[[437mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bg-white" | cat -v) "^[[415mcoucou^[(B^[[m"
}

@test "color background --bash" {
    source colors.sh

    assert_equal $(color "coucou" "bg-black --bash" | cat -v) "^[[0;40mcoucou^[[m"
    assert_equal $(color "coucou" "bg-red --bash" | cat -v) "^[[0;41mcoucou^[[m"
    assert_equal $(color "coucou" "bg-green --bash" | cat -v) "^[[0;42mcoucou^[[m"
    assert_equal $(color "coucou" "bg-yellow --bash" | cat -v) "^[[0;43mcoucou^[[m"
    assert_equal $(color "coucou" "bg-blue --bash" | cat -v) "^[[0;44mcoucou^[[m"
    assert_equal $(color "coucou" "bg-purple --bash" | cat -v) "^[[0;45mcoucou^[[m"
    assert_equal $(color "coucou" "bg-cyan --bash" | cat -v) "^[[0;46mcoucou^[[m"
    assert_equal $(color "coucou" "bg-white --bash" | cat -v) "^[[0;47mcoucou^[[m"
}

@test "color background --hex" {
    source colors.sh

    assert_equal $(color "coucou" "bg-black --hex" | cat -v) "^[[0;40mcoucou^[[m"
    assert_equal $(color "coucou" "bg-red --hex" | cat -v) "^[[0;41mcoucou^[[m"
    assert_equal $(color "coucou" "bg-green --hex" | cat -v) "^[[0;42mcoucou^[[m"
    assert_equal $(color "coucou" "bg-yellow --hex" | cat -v) "^[[0;43mcoucou^[[m"
    assert_equal $(color "coucou" "bg-blue --hex" | cat -v) "^[[0;44mcoucou^[[m"
    assert_equal $(color "coucou" "bg-purple --hex" | cat -v) "^[[0;45mcoucou^[[m"
    assert_equal $(color "coucou" "bg-cyan --hex" | cat -v) "^[[0;46mcoucou^[[m"
    assert_equal $(color "coucou" "bg-white --hex" | cat -v) "^[[0;47mcoucou^[[m"
}

@test "color background --oct" {
    source colors.sh


    assert_equal $(color "coucou" "bg-black --oct" | cat -v) "^[[0;40mcoucou^[[m"
    assert_equal $(color "coucou" "bg-red --oct" | cat -v) "^[[0;41mcoucou^[[m"
    assert_equal $(color "coucou" "bg-green --oct" | cat -v) "^[[0;42mcoucou^[[m"
    assert_equal $(color "coucou" "bg-yellow --oct" | cat -v) "^[[0;43mcoucou^[[m"
    assert_equal $(color "coucou" "bg-blue --oct" | cat -v) "^[[0;44mcoucou^[[m"
    assert_equal $(color "coucou" "bg-purple --oct" | cat -v) "^[[0;45mcoucou^[[m"
    assert_equal $(color "coucou" "bg-cyan --oct" | cat -v) "^[[0;46mcoucou^[[m"
    assert_equal $(color "coucou" "bg-white --oct" | cat -v) "^[[0;47mcoucou^[[m"
}


@test "color styles --default" {
    source colors.sh

    assert_equal $(color "coucou" "normal" | cat -v) "^[(B^[[mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "bold" | cat -v) "^[[1mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "low_intensity" | cat -v) "^[[2mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "underline" | cat -v) "^[[4mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "blink" | cat -v) "^[[5mcoucou^[(B^[[m"
    assert_equal $(color "coucou" "reverse" | cat -v) "^[[7mcoucou^[(B^[[m"
    # assert_equal $(color "coucou" "invisible" | cat -v) "^[[8mcoucou^[(B^[[m"
}

@test "color styles --bash" {
    source colors.sh

    assert_equal $(color "coucou" "normal --bash" | cat -v) "coucou"
    assert_equal $(color "coucou" "bold --bash" | cat -v) "^[[1mcoucou^[[m"
    assert_equal $(color "coucou" "low_intensity --bash" | cat -v) "^[[2mcoucou^[[m"
    assert_equal $(color "coucou" "underline --bash" | cat -v) "^[[4mcoucou^[[m"
    assert_equal $(color "coucou" "blink --bash" | cat -v) "^[[5mcoucou^[[m"
    assert_equal $(color "coucou" "reverse --bash" | cat -v) "^[[7mcoucou^[[m"
    assert_equal $(color "coucou" "invisible --bash" | cat -v) "^[[8mcoucou^[[m"
}

@test "color styles --hex" {
    source colors.sh

    assert_equal $(color "coucou" "normal --hex" | cat -v) "coucou"
    assert_equal $(color "coucou" "bold --hex" | cat -v) "^[[1mcoucou^[[m"
    assert_equal $(color "coucou" "low_intensity --hex" | cat -v) "^[[2mcoucou^[[m"
    assert_equal $(color "coucou" "underline --hex" | cat -v) "^[[4mcoucou^[[m"
    assert_equal $(color "coucou" "blink --hex" | cat -v) "^[[5mcoucou^[[m"
    assert_equal $(color "coucou" "reverse --hex" | cat -v) "^[[7mcoucou^[[m"
    assert_equal $(color "coucou" "invisible --hex" | cat -v) "^[[8mcoucou^[[m"
}

@test "color styles --oct" {
    source colors.sh


    assert_equal $(color "coucou" "normal --oct" | cat -v) "coucou"
    assert_equal $(color "coucou" "bold --oct" | cat -v) "^[[1mcoucou^[[m"
    assert_equal $(color "coucou" "low_intensity --oct" | cat -v) "^[[2mcoucou^[[m"
    assert_equal $(color "coucou" "underline --oct" | cat -v) "^[[4mcoucou^[[m"
    assert_equal $(color "coucou" "blink --oct" | cat -v) "^[[5mcoucou^[[m"
    assert_equal $(color "coucou" "reverse --oct" | cat -v) "^[[7mcoucou^[[m"
    assert_equal $(color "coucou" "invisible --oct" | cat -v) "^[[8mcoucou^[[m"
}