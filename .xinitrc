#!/bin/sh

exec dbus-run-session sh -c '

export GDK_BACKEND=x11
export QT_QPA_PLATFORMTHEME="qt5ct"
export SAL_USE_VCLPLUGIN=gtk3

mixer vol=0.50:0.30
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.20
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 0.20
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xsetroot -cursor_name left_ptr
setxkbmap -layout br -variant thinkpad
xhost +local:

feh --bg-fill ~/Pictures/Wallpapers/nagato1.1.jpg &
picom &
/home/ivan/Scripts/dzen2.sh &
tint2 &
xbindkeys &
redshift -l -27.596670:-48.549170 -t 6000:4800 &

xidle -area 3 -delay 0 -sw -program "/usr/local/bin/skippy-xd" &
xidle -area 3 -delay 0 -se -program "/home/ivan/Scripts/desktop.sh" &
xidle -program /usr/local/bin/slock -timeout 360 &

sleep 1
tmux new-session -d -s chat_session nchat &
mpg123 /home/ivan/Music/Sounds/macOS_X.mp3 > /dev/dsp 2> /dev/null & 

exec openbox
'
