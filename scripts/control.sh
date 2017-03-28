#!/bin/sh
if [ "$1" = "stop" ] || [ "$1" = "restart" ]; then
    case $2 in
        bar)
            killall bartender && killall lemonbar
            ;;
        dunst)
            killall dunst
            ;;
    esac
fi

if [ "$1" = "start" ] || [ "$1" = "restart" ]; then
    case $2 in
    bar)
        bartender 2> ~/bartender_log | lemonbar -p -g 1440x20+0+0 > /dev/null &
        ~/dotfiles/scripts/volume.sh init &
        ~/dotfiles/scripts/network.sh > ~/tmp/net_fifo &
        ;;
    dunst)
        dunst -shrink &
        ;;
    esac
fi
