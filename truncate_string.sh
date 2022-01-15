#!/bin/sh

truncate_string() {
    __string="$1"
    __width="$2"
    while [ "$__width" -gt 0 ]; do
        __string="${__string%?}"
    done

}


