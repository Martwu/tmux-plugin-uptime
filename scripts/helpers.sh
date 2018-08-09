#!/usr/bin/env bash

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value="$(tmux show-option -gqv "$option")"
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

is_osx() {
    [ $(uname) == "Darwin" ]
}

is_linux() {
    [ $(uname) == "Linux" ]
}

uptime_ts() {
    boot_ts=$1
    echo "$(date +%s)-${boot_ts}" | bc
}

cal() {
    echo $1 | bc
}

format_uptime() {
    ts=$1
    secs=$(cal "${ts}%60")
    mins_t=$(cal "${ts}/60")
    display="${secs}s"
    if [ $mins_t -eq 0 ]
    then
        echo $display
        return
    fi
    mins=$(cal "${mins_t}%60")
    hours_t=$(cal "${mins_t}/60")
    display="${mins}m ${display}"
    if [ $hours_t -eq 0 ]
    then
        echo $display
        return
    fi
    hours=$(cal "${hours_t}%24")
    days_t=$(cal "${hours_t}/24")
    display="${hours}h ${display}"
    if [ $days_t -eq 0 ]
    then
        echo $display
        return
    fi
    echo "${days_t}d ${display}"
}

command_exists() {
    local command="$1"
    type "$command" >/dev/null 2>&1
}
