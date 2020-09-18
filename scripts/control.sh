#!/bin/sh
if [ "$1" = "stop" ] || [ "$1" = "restart" ]; then
    case $2 in
        dunst)
            pkill dunst
            ;;
        sct)
            pkill sctd
            ;;
        wallpaper)
            pkill wallpaper
            ;;
    esac
fi

if [ "$1" = "start" ] || [ "$1" = "restart" ]; then
    case $2 in
    bar)
        bartender 2> ~/bartender_log | lemonbar -p -g 1440x20+0+0 > /dev/null &
        ~/dotfiles/scripts/volume.sh init &
        if pgrep gpg-agent > /dev/null; then
            echo "+" > ~/tmp/gpg_status_fifo
        fi
        ~/dotfiles/scripts/network.sh > ~/tmp/net_fifo &
        ;;
    dunst)
        dunst -shrink &
        ;;
    sct)
        ~/dotfiles/sct/sctd.sh > /dev/null &
        ;;
    wallpaper)
        ~/dotfiles/scripts/wallpaper.sh > /dev/null &
        ;;
    esac
fi
