#!/bin/sh

exec dbus-run-session sh -c '

export XCURSOR_SIZE=32
export GDK_BACKEND=x11
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_LOGGING_RULES="qt.qpa.theme.gnome=false"

mixer vol=0.35:0.30
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.20
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 0.20
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xsetroot -cursor_name left_ptr
setxkbmap -layout br -variant thinkpad
xhost +local:

feh --bg-fill ~/Pictures/Wallpapers/chatos/cristo_no_deserto.png &
picom &
/home/ivan/Scripts/dzen2.sh &
tint2 &
xbindkeys &
redshift -l -27.596670:-48.549170 -t 6000:4800 &

tmux new-session -d -s chat_session nchat &
mpg123 /home/ivan/Music/Sounds/macOS_X.mp3 > /dev/dsp 2> /dev/null & 

sleep 3 && wpa_gui -t &

exec bspwm
'

