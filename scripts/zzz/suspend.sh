#!/bin/sh
doas -u twk gpgconf --kill gpg-agent
echo "" > /home/twk/tmp/gpg_status_fifo
intel_reg read 0x00061254 2> /dev/null | sed "s/.*: //" > /home/twk/tmp/backlight
DISPLAY=:0 doas -u twk slock &
sleep .2
