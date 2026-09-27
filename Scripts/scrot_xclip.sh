#!/bin/sh

AREA=$(slop --highlight --tolerance=0 --color=0.3,0.4,0.6,0.4 -f "%x, %y, %w, %h") || exit 0

FILE="/tmp/scrot$(date +-%F-%H%M%S).png"

if scrot -a "$AREA" -F "$FILE"; then
	notify-send "$FILE" > /dev/null
	xclip -selection clipboard -t image/png -i "$FILE"
fi
