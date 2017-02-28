#!/bin/sh
doas -u twk gpgconf --kill gpg-agent
DISPLAY=:0 doas -u twk slock &
sleep .2
