#!/bin/sh

main=$(printf "Search\nTerm\nfm\nBrowsers\nMail\nPodman\nPostgreSQL\nCaffeine\ni2pd\nVOSS\ntailscale\nVPN\nwebcamd\nUnmount\nPrint\nxkill\nslock\nRe_Wifibox\nSuspend\nLog_Out\nReboot\nPower_Off\n" | dmenu -b -fn monospace:size=8 -sb red)

case "$main" in
Search)
    dmenu_run -b -fn monospace:size=8 -sb red &
	;;
Term)
    /home/ivan/Scripts/term.sh &
	;;
fm)
    /home/ivan/Scripts/thunar.sh &
	;;
Browsers)
   app=$(printf "Librewolf\nTor\n" | dmenu -b -fn monospace:size=8 -sb red)
   case "$app" in
   Librewolf)
		doas jexec -u ivan browsers librewolf &
		;;
   Tor)
	    doas jexec -u ivan browsers tor-browser &
   esac
   ;;
Mail)
    claws-mail &
	;;
Podman)
    app=$(printf "pgadmin4_start\npgadmin4_stop\n" | dmenu -b -fn monospace:size=8 -sb red)
    case "$app" in 
    pgadmin4_start)
        /home/ivan/Scripts/podman_start.sh &
        ;;
    pgadmin4_stop)
        /home/ivan/Scripts/podman_stop.sh &
    esac
    ;;
PostgreSQL)
   app=$(printf "Start_Service\nStop_Service\n" | dmenu -b -fn monospace:size=8 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/postgresql_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/postgresql_stop.sh &
   esac
   ;;
Caffeine)
    caffeine &
    ;;
i2pd)
   app=$(printf "Start_Service\nStop_Service\n" | dmenu -b -fn monospace:size=8 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/i2pd_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/i2pd_stop.sh &
   esac
   ;;
VOSS)
   app=$(printf "Start_Service\nStop_Service\n" | dmenu -b -fn monospace:size=8 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/voss_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/voss_stop.sh &
   esac
   ;;
tailscale)
   app=$(printf "Start_Service\nStop_Service\nmount\n" | dmenu -b -fn monospace:size=8 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/start_tails.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/stop_tails.sh &
        ;;
   mount)
       /home/ivan/Scripts/mount_tails.sh &
   esac
   ;;
VPN)
   app=$(printf "Start_Service\nStop_Service\n" | dmenu -b -fn monospace:size=8 -sb red)
   case "$app" in
   Start_Service)
		/home/ivan/Scripts/vpn_start.sh &
		;;
   Stop_Service)
		/home/ivan/Scripts/vpn_stop.sh &
   esac
   ;;
webcamd)
   app=$(printf "Start_Service\nStop_Service\npwcview\n" | dmenu -b -fn monospace:size=8 -sb red)
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
Print)
    /home/ivan/Scripts/scrot.sh &
	;;
xkill)
    xkill &
	;;
slock)
    slock &
	;;
Re_Wifibox)
    /home/ivan/Scripts/wifibox.sh &
	;;
Suspend)
    /home/ivan/Scripts/lock.sh &
	;;
Log_Out)
    pkill x &
	;;
Reboot)
    /home/ivan/Scripts/reboot.sh &
	;;
Power_Off)
    /home/ivan/Scripts/poweroff.sh &
esac
