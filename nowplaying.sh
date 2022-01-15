#!/bin/sh

# nowplaying.sh – A simple, POSIX-compliant shell script to print the
# "Now Playing" status of a local Plex Server to stdout.
#
# Copyright 2022 Justin Teague <arcadellama@posteo.net>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the “Software”),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

PRGNAM="nowplaying.sh"
PRG_VERSION="0.2"

PLEX_HOST="${PLEX_HOST:-}"      # Plex server IP(s), separated by space
MAX_WIDTH=${MAX_WIDTH:-100}     # Set the maximum width of print
TERM_MARGIN=${TERM_MARGIN:-8}   # Set the margin for term

## Functions

print_help() {
cat <<EOF
nowplaying.sh – a simple, POSIX-compliant script to print the "Now Playing"
                status to stdout.

    Usage: '"$PRGNAM" -s "<IP Address of Plex Server>'"

                -s  IP address(es) of Plex Server in quotes, separated
                    by spaces.

EOF
}

truncate_string() {
    __string="$1"
    __width="$2"
    __count="$(((${#__string} - __width) + 3))" # 3 additional for elipses

    while [ "$__count" -gt 0 ]; do
        __string="${__string%?}"
        __count="$((__count - 1))"
    done

    printf "%s..." "$__string"
}

print_nowplaying() {
    __count="$1"
    __album="$2"
    __track="$3"
    __title="$4"
    __user="$5"
    __type="$6"
    __columns="$("$(command -v tput)" cols)"

    if [ "$__columns" -gt "$MAX_WIDTH" ]; then
       __columns="$MAX_WIDTH"
    fi

    __col1="$((${#__count} + 1))"
    __col3="$((${#__user} + 2))"
    __col2="$((__columns - (__col3 +  __col1) - 4))"

    case "$__type" in
        episode)
              __title="${__album}: ${__track}"

              if [ "${#__title}" -gt "$__col2" ]; then
                  
                  if [ "${#__album}" -gt "$__col2" ]; then
                  __album="$(truncate_string "$__album" "$__col2")"
                  fi
                  
                  if [ "${#__track}" -gt "$__col2" ]; then
                  __track="$(truncate_string "$__track" "$__col2")"
                  fi
                  
                  printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                      "$__count." "$__album" ""
                  printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                      "" "$__track" "$__user"

                else

                  printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                      "$__count." "$__title" "$__user"
              fi
            ;;

          track)
              __title="${__album}: ${__track}"

              if [ "${#__title}" -gt "$__col2" ]; then
                  
                  if [ "${#__album}" -gt "$__col2" ]; then
                  __album="$(truncate_string "$__album" "$__col2")"
                  fi
                  
                  if [ "${#__track}" -gt "$__col2" ]; then
                  __track="$(truncate_string "$__track" "$__col2")"
                  fi
                  
                  printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                      "$__count." "$__album" ""
                  printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                      "" "$__track" "$__user"

                else

                  printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                      "$__count." "$__title" "$__user"
              fi
            ;;

          movie)
              if [ "${#__title}" -gt "$__col2" ]; then
                  __title="$(truncate_string "$__title" "$__col2")"
              fi
              printf "%${__col1}s %-${__col2}s %${__col3}s\n" \
                  "$__count." "$__title" "$__user"
            ;;
    esac
}

get_host() {
    set -- ${PLEX_HOST}
    for __host in "$@"; do
        if ping -c1 -t1 "$__host" >/dev/null ; then
            printf "%s" "$__host"
            return 0
        fi
    done 
    exit 0
}

get_element() {
    echo "${2}" | grep -Eo "${1}=\"[a-zA-Z0-9?!&()#:;.,-_ ]*\"" | \
        cut -d '=' -f 2 | tr -d '"' | sed -e "s/\&\#39\;/'/g"
}

get_plexml() {
    curl -s http://"$(get_host)":32400/status/sessions
}

parse_plexml() {
    __title=""
    __user=""
    __album=""
    __track=""
    __type=""
    #__series=""
    #__episode=""

    __count=0
    while IFS= read -r line; do
        case "$(get_element "type" "$line")" in
          episode)
                  __type="episode"
                  __album="$(get_element "grandparentTitle" "$line")"
                  __track="$(get_element "title" "$line")"
                  #__title="$(printf "%s:\n\t%s" "${__album}" "${__track}")"
                  continue ;;
          track)
              __type="track"
              __album="$(get_element "grandparentTitle" "$line")"
              __track="$(get_element "title" "$line")"
              #__title="$(printf "%s:\n\t%s" "${__album}" "${__track}")"
              continue ;;
          movie)
              __type="movie"
              __title="$(get_element "title" "$line")"
              continue ;;
        esac

        if echo "$line" | grep -q 'User id'; then
            __user="$(get_element "title" "$line")"
            if [ "$__count" -eq 0 ]; then
                printf "Now Playing on Plex:\n"
                __count="$((__count+1))"
            fi
            print_nowplaying "$__count" "$__album" "$__track" \
                "$__title" "$__user" "$__type"
            __count="$((__count+1))"

            continue
        fi

    done << EOF
    "$(get_plexml)"
EOF
}

while [ "$#" -gt 0 ]; do
    case "$1" in 
        -s)
            PLEX_HOST="$2"
            shift 2 ;;
        -h)
            print_help
            exit 0 ;;
    esac
done

parse_plexml

#exit 0
