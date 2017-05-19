#!/bin/sh
sleep .2

if [ "$2" = "up" ]; then
    nohup "$DOTFILES"/scripts/clubstatus.sh < /dev/null > /dev/null 2>&1 &
elif [ "$2" = "down" ]; then
    pkill clubstatus.sh
fi
