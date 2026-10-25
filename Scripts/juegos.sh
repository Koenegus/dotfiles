#!/bin/sh

dir(){
    /home/ivan/Scripts"$@" 2>/dev/null
}

echo "Options: 
1 - Air
2 - Kanon
3 - Clannad
4 - Snow 
5 - ef
6 - Akai Ito
7 - Fate Hollow Ataraxia
8 - Little Witch Romanesque
9 - Tears to Tiara
10 - Yu-Gi-Oh! Joey The Passion
11 - Victoria II
12 - Colin McRae Rally 2
13 - Rewrite+
"

read -p "Choose: " op

case $op in
		1)	    dir /air.sh
				;;
		2)		dir /kanon.sh
				;;
		3)      dir /clannad.sh
                ;;
        4)      dir /snowpe.sh
                ;;
        5)      dir /ef.sh
                ;;
        6)      dir /akaito.sh
                ;;
        7)      dir /fate.sh
                ;;
        8)      dir /lwr.sh
                ;;
        9)      dir /TtT.sh
                ;;
        10)     dir /yugi.sh
                ;;
        11)     dir /vic2.sh
                ;;
        12)     dir /cmr2.sh
                ;;
        13)     dir /rewrite.sh
                ;;
        quit)   echo "ciao $USER"
                ;;
        exit)   echo "ciao $USER"
                ;;
		*)		echo "????"
                ;;
esac
