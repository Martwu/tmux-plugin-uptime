#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_uptime() {
    if is_osx
    then
        boot_ts=$(sysctl kern.boottime | awk -F'[ ,]' '{print $5}')
    elif is_linux
    then
        boot_ts=$(echo "$(date +%s) - $(cat /proc/uptime | awk -F'[ .]' '{print $1}')" | bc)
    else
        boot_ts="0"
    fi
    echo $(format_uptime "$(uptime_ts $boot_ts)")
}

main() {
    print_uptime
}

main
