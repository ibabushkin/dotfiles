#!/bin/sh
emacsclient -a "" -e '(twk/open-scratch-frame)' && i3-msg "[id=$(xdotool getactivewindow)] floating enable"
