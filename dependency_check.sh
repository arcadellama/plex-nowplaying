#!/usr/bin/env sh


dependency_check() {
    # Let's make sure everything is here
    for __coreutil in tput grep cut sed; do
        if [ ! "$(command -v $__coreutil)" ]; then
            printf "Error: \"%s\" not found.\n" "$__coreutil"
            return 1
        fi
    done

    for __dl_agent in curl wget; do
        DL_AGENT="$(command -v $__dl_agent)"
        if [ ! -z "$DL_AGENT" ]; then
            return 0
        fi
    done
    printf "Error: neither curl nor wget found.\n"
    return 1
}

if dependency_check; then 
    echo "Still running"
    exit 0
else
    exit 1
fi
