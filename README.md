# plex-nowplaying

### A CLI script to show the "Plex Now Playing" status in your terminal.

![Image](/.github/images/nowplaying-screenshot.png)

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
- A download agent; unless specified, will curl, wget, fetch, and nc (ncat/netcat) in that order.

### Installation
Clone this repo:

    git clone git@github.com:arcadellama/plex-nowplaying.git

Copy or link the script "nowplaying" it into your path, (e.g., ~/.local/bin, or /usr/local/bin). Without any arguments it looks for a Plex server running on your local server.

See "Configuration" below for more options.

I have put it in my .bashrc for the screenshot seen above.

### Usage

    Example: 'nowplaying -p 192.168.1.1 -w 80 -t <PLEX_AUTH_TOKEN>'
    
               --help, -h   This screen
    
      --config, -c <file>   Configuration file. Overrides command args.
      
          --plex, -p <ip>   IP address(es) or domain name of Plex Server
                            separated by commas, no spaces.
                            Default=127.0.0.1
    
           --port <number>   Plex port (default: 32400)
    
        --token, -t <path>   Plex Auth Token, optional point to file.
    
         --timeout <value>   Time to wait for connection, default=1
    
          --color <on|off>   Color setting. Default is to attempt to discover
                             your terminal settings and set accordingly.
    
      --width, -w <number>   Maximum number of columns width.
                             Default=0, "infinite"
    
             --version, -v  Show version
    
             --curl <path>  Force curl as downloader.
                            (Path is optional.)
    
             --wget <path>  Force wget as downloader.
                            (Path is optional.)
    
            --fetch <path>   Force fetch as downloader.
                             (Path is optional.)
    
      --netcat,--nc <path>   Force netcat (nc) as downloader.
                             (Path is optional.)
     
                 --verbose   Print every error message.
    
                    --file   Point to a XML file for debugging
    
## Configuration File
Your Plex Server IP and Tokens probably shouldn't be version controlled for the world to see. You can create a configuration file, example is given at nowplaying.conf.sample, and use the "--config </path/to/file>"

Current options are:  

    NP_PLEX_HOST=0.0.0.0  
    NP_PLEX_PORT=32400  
    NP_PLEX_TOKEN=xxxxxxxx  

### Why can you add more than one Plex host?
This is for checking the same host that might have a different address, depending on your setting. E.g., on a notebook you might have both a LAN address and also the Wireguard address. **It is not intended to poll more than one Plex server at a time.** While you certainly could, the script will stop once it finds a working Plex server.

### What does verbose do?
By default, the script will only show a result if it finds a Plex server with media playing. 'Verbose' mode will tell you why nothing was printed on screen, either because your Plex server has nothing playing, or because it can't be reached.

### Exit Codes
-   0     Everything works
-   1     Something went wrong
-   2-99  Plex server unreachable/timeout 

### Roadmap
- [x] Add PLEX AUTH TOKEN option for servers without local auth turned off
- [x] Remove BASHisms and make it pure sh/posix compatible
- [x] Add transcoding indicator
- [x] Remove the dependancy on grep, sed, cut, and tput
- [x] Add colors, bold, italics, etc.
- [x] Fix exit codes
- [x] Add netcat (nc) as a default download agent
- [x] Add global timeout variable for download agent
- [x] Add an option for external config file and/or environment variables
