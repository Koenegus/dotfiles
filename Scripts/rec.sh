#!/bin/sh

AREA=$(slop --highlight --tolerance=0 --color=0.3,0.4,0.6,0.4 -f "%x %y %w %h") || exit 0

set -- $AREA

X=$1
Y=$2
W=$3
H=$4

W=$((W / 2 * 2))
H=$((H / 2 * 2))

ffmpeg \
    -f x11grab \
    -framerate 60 \
    -video_size ${W}x${H} \
    -i :0.0+${X},${Y} \
    -c:v libx264 \
    -pix_fmt yuv420p \
    -preset ultrafast \
    -crf 25 \
    -movflags +faststart \
    "/home/ivan/Videos/Rec/rec-$(date +%F-%H%M%S).mp4"


