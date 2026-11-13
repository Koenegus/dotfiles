#!/bin/sh

video() {
    yt-dlp --flat-playlist --print "%(title)s | https://www.youtube.com/watch?v=%(id)s" "https://www.youtube.com/"$@"" 2> /dev/null
}

read -p "Enter the channel @: " op

video $op | less
