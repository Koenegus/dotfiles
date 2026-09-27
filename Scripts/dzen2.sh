#!/bin/sh

DZEN_OPTS="-dock -ta c -e 'button3=' -p -fn Monospace:size=8 -w 1920 -h 20 -x 0 -y 1080"

while true; do
    env TERM=dumb top -b -d 2 | awk '
        /CPU:/ { cpu = $0 }
        /Mem:/ { mem = $0 }
        /ARC:/ { arc = $0 }
		/Swap:/ { swap = $0 }

		END { printf " %s | %s | %s | %s \n", cpu, mem, arc, swap}
    '
done | dzen2 ${DZEN_OPTS}
