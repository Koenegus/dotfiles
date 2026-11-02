#!/bin/sh
if xset q | grep -q "DPMS is Enabled"; then
    xset s off -dpms
    notify-send -i /usr/local/share/icons/Papirus/48x48/categories/caffeine.svg "Caffeine" "Service on"
else
    xset s on
    xset s 600 600
    xset +dpms
    xset dpms 600 600 600
    notify-send -i /usr/local/share/icons/Papirus/48x48/categories/caffeine.svg "Caffeine" "Service OFF"
fi
