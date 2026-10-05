#!/bin/sh

dir="/home/ivan/Videos/Rec/rec-$(date +%F-%H%M%S).mp4"

rec() {
    ffmpeg \
        -f x11grab \
        -framerate 60 \
        -video_size ${W}x${H} \
        -i :0.0+${X},${Y} \
        -c:v libx264 \
        -pix_fmt yuv420p \
        -preset fast \
        -crf 25 \
        -movflags +faststart \
        "$@" 
}

echo "Options:
1 - Video
2 - Video + Mic
3 - Video + Loopback (VOSS)
4 - Video + Loopback (VOSS) + Mic
"

read -p "Choose: " op

case $op in
    1|2|3|4)
        ;;
    *)
        echo "Invalid option!!!"
        exit 1
        ;;
esac

AREA=$(slop --highlight --tolerance=0 --color=0.3,0.4,0.6,0.4 -f "%x %y %w %h") || exit 0

set -- $AREA

X=$1
Y=$2
W=$3
H=$4

W=$((W / 2 * 2))
H=$((H / 2 * 2))

case $op in
    1) rec "$dir"
       ;;
    2) rec "$dir" -f oss -i /dev/dsp1
       ;;
    3) rec "$dir" -f oss -i /dev/vdsp.loopback
       ;;
    4) rec "$dir" -f oss -i /dev/vdsp.loopback -f oss -i /dev/dsp -filter_complex "[1:a][2:a]amix=inputs=2:duration=longest:normalize=0" -map 0:v -map 1:a
       ;;
esac
