# nowplaying.sh
## a simple, POSIX-compliant script to print the "Now Playing" status of a Plex server to stdout.

![Image](/images/screenshot.png)

Example: '"$PRGNAM" -p localhost,127.0.0.1,192.168.1.1 -w 80 -d "." 

        --plex, -p    IP address(es) or domain name of Plex Server
                      separated by commas, no spaces.
                      Default=localhost,127.0.0.1

        OPTIONAL PARAMATERS:

        --width, -w   Maximum number of columns width.
                      Default=0, "infinite"
        --delim, -d   Dot leader for display. Default = "."
       
        --force, -f   Skip dependency checks.

        --curl        Force curl as downloader.
        --wget        Force wget as downloader.
        --fetch       Force fetch as downloader.



