#!/bin/sh
sleep .2
"$DOTFILES"/scripts/network.sh > "$MYHOME"/tmp/net_fifo

if [ "$2" = "up" ]; then
    "$DOTFILES"/scripts/clubstatus.sh > /dev/null &
    disown
elif [ "$2" = "down" ]; then
    pkill clubstatus.sh
fi
