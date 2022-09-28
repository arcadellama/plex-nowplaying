#!/usr/bin/env sh

test_array="
10.0.111:32400,null.com:23500,example.com:11100
172.168.111.1:32400,10.0.1.1:32400,justin.org:12345
99.99.99.99:12345,elementary.com:3456,1.1.1.1:9999
"

set -f
set -- $test_array
for line in "$@"; do
    old_ifs=$IFS
    IFS=,
    set -- $line
    for uri in "$@"; do
        case "$uri" in
            *n*) continue ;;
            *) echo "$uri" ;;
        esac
    done
    IFS=$old_ifs
done
set +f
