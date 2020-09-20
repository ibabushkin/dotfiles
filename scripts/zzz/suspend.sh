#!/bin/sh
kill -HUP "$(pidof gpg-agent)" && echo "" > /home/twk/tmp/gpg_status_fifo
intel_reg read 0x00061254 2> /dev/null | sed "s/.*: //" > /home/twk/tmp/backlight
DISPLAY=:0 doas -u twk nohup i3lock -i /home/twk/images/wallpapers/old/browser.png > /dev/null &
sleep .2
