#!/usr/bin/env sh


check_uri() {
    case "$1" in
             *:*) return ;;
               *) return 1 ;;
    esac
}

for i in "192.168.111.1:32400" "10.0.1.1" "null.com:114800"; do
    if check_uri "$i"; then
        echo "$i is a valid uri."
    fi
done
