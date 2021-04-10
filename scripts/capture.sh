#!/bin/sh
emacsclient -a "" -e '(+org-capture/open-frame "" "c")' && i3-msg "[id=$(xdotool getactivewindow)] floating enable"
