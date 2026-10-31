#!/bin/sh

echo "Options: 
1 - Digital Animation - x265
2 - Cel Animation - x265
3 - Digital Animation - x264
4 - Cel Animation - x264
"

read -p "Choose: " op 

case $op in
    1)
    mkdir -p Encoded
    for file in *.mkv; do
        ffmpeg -i "$file" \
        -c:v libx265 \
        -preset slow \
        -crf 20 \
        -x265-params "profile=main10" \
        -tune animation \
        -c:a copy -c:s copy \
        "Encoded/${file%.*}.mkv"
    done
    ;;
    2)
    mkdir -p Encoded
    for file in *.mkv; do
        ffmpeg -i "$file" \
        -c:v libx265 \
        -preset slow \
        -crf 22 \
        -x265-params "profile=main10" \
        -tune animation \
        -vf "nlmeans=s=1.5" \
        -c:a copy -c:s copy \
        "Encoded/${file%.*}.mkv"
    done
    ;;
    3)
    mkdir -p Encoded
    for file in *.mkv; do
        ffmpeg -i "$file" \
        -c:v libx264 \
        -preset fast \
        -profile:v high10 -pix_fmt yuv420p10le \
        -crf 20 \
        -tune animation \
        -c:a copy -c:s copy \
        "Encoded/${file%.*}.mkv"
    done
    ;;
    4)
    mkdir -p Encoded
    for file in *.mkv; do
        ffmpeg -i "$file" \
        -c:v libx264 \
        -preset fast \
        -profile:v high10 -pix_fmt yuv420p10le \
        -crf 20 \
        -tune animation \
        -vf "hqdn3d=4:4:8:8" \
        -c:a copy -c:s copy \
        "Encoded/${file%.*}.mkv"
    done
    ;;
esac
    





