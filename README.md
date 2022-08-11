# nowplaying.sh

### a pure sh POSIX script to print the "Plex Now Playing" status to stdout.

![Image](/.github/images/screenshot.png)

[![GitHub Super-Linter](https://github.com/arcadellama/nowplaying.sh/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)

### Purpose
This started out as a quick way to make sure I didn't kick anyone off Plex before doing an update or server reboot. It has become a little bit of of a hobby project to learn more about how the shell works, including a built-in XML parser.

### Features
- Fully POSIX-compliant
- Tested on macOS, Debian, Ubuntu, Fedora, Slackware, and FreeBSD
- Now works with a [PLEX AUTH TOKEN](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/)
- Green solid indicator for hardware transcoding, open indicator for software transcoding

### Dependencies
- A posix compatible shell (sh, bash, ksh, dash)
- curl, wget, or fetch

### Installation
Clone this repo:

    git clone git@github.com:arcadellama/nowplaying.sh

Copy or link the script "nowplaying" it into your path, (e.g., ~/.local/bin, or /usr/local/bin). Without any arguments it looks for a Plex server running on your local server.
See "Configuration" below for more options.

I have put it in my .bashrc and pipe it into "lolcat" because it makes me happy.

### Configuration

    Example: nowplaying -p 192.168.1.1 --token <PLEX_AUTH_TOKEN>          
            --plex, -p    IP address(es) or domain name of Plex Server
                          separated by commas, no spaces.
                          Default=127.0.0.1

            --token, -t   Plex Auth Token

            --width, -w   Maximum number of columns width.
                          Default=0, "infinite"

             --help, -h   This screen

          --version, -v   Show version

          --curl <path>   Force curl as downloader.
                          (Path is optional.)

          --wget <path>   Force wget as downloader.
                          (Path is optional.)

         --fetch <path>   Force fetch as downloader.
                          (Path is optional.)

                 --file   Point to a XML file for debugging
### Exit Codes
-   0     Everything works, something is playing
-   1     Something went wrong
-   2-99  Plex server unreachable/timeout
-   222   Everything works, nothing playing 

### Roadmap
- [x] Add PLEX AUTH TOKEN option for servers without local auth turned off
- [x] Remove BASHisms and make it pure sh/posix compatible
- [x] Add transcoding indicator
- [x] Remove the dependancy on grep, sed, cut, and tput
- [x] Add colors, bold, italics, etc.
- [x] Fix exit codes
