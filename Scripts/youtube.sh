#!/bin/sh

video() {
    yt-dlp --flat-playlist --print "%(title)s | https://www.youtube.com/watch?v=%(id)s" "https://www.youtube.com/"$@"" 2> /dev/null
}

search(){
    yt-dlp --flat-playlist --print "%(title)s | https://www.youtube.com/watch?v=%(id)s" "ytsearch50:"$@"" 2> /dev/null
}

echo "Options: 
1 - Channel page
2 - Search for a video
"
read -p "Choose: " op

case $op in
    1)  read -p "Channel @: " vid
        video $vid | less
        ;;
    2)  read -p "Search: " se
        search $se | less
        ;;
    *) echo "???"
        ;;
esac
