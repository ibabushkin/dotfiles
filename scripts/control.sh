#!/bin/bash
if [[ "$1" = "stop" || "$1" = "restart" ]]; then
    case $2 in
        bar)
            killall bartender && killall lemonbar
            ;;
        dunst)
            killall dunst
            ;;
    esac
fi

if [[ "$1" = "start" || "$1" = "restart" ]]; then
    case $2 in
    bar)
        bartender | lemonbar -p -g 1440x20+0+0 > /dev/null &
        ~/dotfiles/scripts/volume.sh init &
        ;;
    dunst)
        dunst &
        ;;
    esac
fi
