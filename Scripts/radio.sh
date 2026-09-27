#!/bin/sh
listen="mpv --no-audio-display --input-ipc-server=/tmp/mpv.sock "
yout="mpv --no-video --input-ipc-server=/tmp/mpv.sock "
dir="/home/ivan/Music/"
random="mpv --no-audio-display --input-ipc-server=/tmp/mpv.sock --shuffle "

echo "Options: 
1 - radiosul.net
2 - listen.moe
3 - Canto y Fogón
4 - casiopea
5 - J1GOLD
6 - ottava
7 - gotanno.love
"

read -p "Choose: " op

case $op in
		1)		$listen 'https://paineldj.com.br:20003/stream'
				;;
		2)		$listen 'https://listen.moe/stream'
				;;
		3)      $listen 'https://sp04.servidorrprivado.com:8052/;mp3'
				;;
		4)      $listen 'https://nonstopcasiopea.radioca.st/;'
				;;
		5)	    $listen 'https://jenny.torontocast.com:2000/stream/J1GOLD'
				;;
		6)	    $listen 'https://ottava2.out.airtime.pro/ottava2_a'
				;;
		7)		$listen 'https://radio.gotanno.love/'
				;;
		jaja)   $listen $dir/Sounds/Promotech.mp3
				;;
        falcao) $random $dir/Humor/Falcao/*/*.mp3
                ;;
        choro)  $random $dir/OSTs/Choro\ Club/*/*.flac
                ;;
        quit)   echo "ciao $USER"
                ;;
        exit)   echo "ciao $USER"
                ;;
		*)		echo "????"
                ;;
esac
