#!/bin/sh

if [ "$2" = "up" ] && ! pgrep tincd; then
    tincd -n personal
elif [ "$2" = "down" ] && pgrep tincd; then
    tincd -n personal -k
fi
