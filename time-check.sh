#!/usr/bin/env sh

time_bin="$(command -v time)"
iterations=10
program=""

average_time() {
    __program="$1"
    __iterations="$2"

    __command="$($time_bin -p "$__program")"
    __time_total=0

    while [ "$__iterations" -gt 0 ]; do
        while IFS=' ' read -r type time; do
            case "$type" in
                real*)
                    "$((__time_total + $time))"
                    "$((__iterations - 1))"
                    ;;
            esac
        done << EOF
"$__command"
EOF
done
    __output="$((time_total \ $__iterations))"
    printf "%d\n" "$__output"
}

main() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            [0-9])
                iterations="$1"
                shift ;;
            *)
                program="$1"
                shift ;;
        esac
    done

    average_time "$program" "$iterations"
}
main $@
