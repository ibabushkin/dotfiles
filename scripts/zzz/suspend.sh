#!/bin/sh
doas -u twk gpgconf --kill gpg-agent
echo "" > /home/twk/tmp/gpg_status_fifo
DISPLAY=:0 doas -u twk slock &
sleep .2
