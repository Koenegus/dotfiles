#!/bin/sh

main=$(printf "Search\nTerminal\nFile_Manager\nMail\nCaffeine\ni2pd\nVOSS\nwebcamd\nUnmount\nScreenshot\nxkill\nslock\nRestart_Wifibox\nSuspend\nLog_Out\nReboot\nPower_Off\n" | dmenu -b -fn monospace:size=9 -sb red)

case "$main" in
Search)
    dmenu_run -b -fn monospace:size=10 -sb red &
	;;
Terminal)
    /home/ivan/Scripts/term.sh &
	;;
File_Manager)
    thunar &
	;;
Mail)
    claws-mail &
	;;
Caffeine)
    caffeine &
    ;;
i2pd)
   app=$(printf "Start_Service\nStop_Service\n" | dmenu -b -fn monospace:size=9 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/i2pd_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/i2pd_stop.sh &
   esac
   ;;
VOSS)
   app=$(printf "Start_Service\nStop_Service\n" | dmenu -b -fn monospace:size=9 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/voss_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/voss_stop.sh &
   esac
   ;;
webcamd)
   app=$(printf "Start_Service\nStop_Service\npwcview\n" | dmenu -b -fn monospace:size=9 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/cam_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/cam_stop.sh &
        ;;
   pwcview)
       pwcview &
   esac
   ;;

Unmount)
    /home/ivan/Scripts/umont.sh &
    ;;
Screenshot)
    /home/ivan/Scripts/scrot.sh &
	;;
xkill)
    xkill &
	;;
slock)
    slock &
	;;
Restart_Wifibox)
    /home/ivan/Scripts/wifibox.sh &
	;;
Suspend)
    /home/ivan/Scripts/lock.sh &
	;;
Log_Out)
    pkill x &
	;;
Reboot)
    doas shutdown -r now &
	;;
Power_Off)
    /home/ivan/Scripts/poweroff.sh &
esac
