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
    dunst)
        dunst -shrink &
        ;;
    sct)
        ~/dotfiles/sct/sctd.sh > /dev/null &
        ;;
    wallpaper)
        bgs -z "$HOME/dotfiles/wallpapers/naptime.png" > /dev/null 2>&1
        ;;
    esac
fi
