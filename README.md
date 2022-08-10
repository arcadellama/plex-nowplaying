# nowplaying.sh
### a pure sh POSIX script to print the "Plex Now Playing" status to stdout.

![Image](/.github/images/screenshot.png)

### Purpose
This started out as a quick way to make sure I didn't kick anyone off Plex before doing an update or server reboot. It has become a little bit of of a hobby project to learn more about how the shell works, including a built-in XML parser.

### Features
- Fully POSIX-compliant out of the box
- Tested on macOS, Debian, Ubuntu, Fedora, Slackware, and FreeBSD
- Now works with a [PLEX AUTH TOKEN](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/)
- Green solid indicator for hardware transcoding, open indicator for software transcoding

### Dependencies
- Just about any shell (sh, bash, ksh, dash)
- curl, wget, or fetch (looks in that order)

### Installation
Simply clone and copy the script it into your path, (e.g., ~/.local/bin, or /usr/local/bin). Without any arguments it looks for a Plex server running on your local server.
See "Usage" below for more options.

I have put it in my .bashrc and pipe it into "lolcat" because it makes me happy.

### Configuration

    Example: nowplaying -p 192.168.1.1 --token <PLEX_AUTH_TOKEN> 
            
        --plex, -p    IP address(es) or domain name of Plex Server
                      separated by commas, no spaces.
                      Default=localhost,127.0.0.1

        --token, -t   Plex Auth Token

        --width, -w   Maximum number of columns width.
                      Default=0, "infinite"

         --help, -h   This screen

      --version, -v   Show version

             --curl   Force curl as downloader.

             --wget   Force wget as downloader.

            --fetch   Force fetch as downloader.

             --file   Point to a local XML file for debugging

### Exit Codes
- 0 It worked
- 1 Something went wrong
- 2 Nothing playing

### Roadmap
- [x] Add PLEX AUTH TOKEN option for servers without local auth turned off
- [x] Remove BASHisms and make it pure sh/posix compatible
- [x] Add transcoding indicator
- [x] Remove the dependancy on grep, sed, cut, and tput
- [x] Add colors, bold, italics, etc.
- [ ] Fix exit codes
