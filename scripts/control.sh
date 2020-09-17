#!/bin/sh
if [ "$1" = "stop" ] || [ "$1" = "restart" ]; then
    case $2 in
        bar)
            killall bartender && killall lemonbar
            ;;
        dunst)
            killall dunst
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
        FIFO="$HOME/tmp/net_fifo"
        flock "$FIFO" -c "$HOME/dotfiles/scripts/network.sh > $FIFO" &
        ;;
    dunst)
        dunst -shrink &
        ;;
    sct)
        ~/dotfiles/sct/sctd.sh > /dev/null &
        ;;
    wallpaper)
        bgs -z "$HOME/dotfiles/wallpapers/naptime.png" > /dev/null 2>&1
        # ~/dotfiles/scripts/wallpaper.sh > /dev/null &
        ;;
    esac
fi
