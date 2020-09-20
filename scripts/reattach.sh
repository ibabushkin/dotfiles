#!/bin/sh
# read in the currently active tmux sessions
session=$(tmux list-sessions | rofi -dmenu -i | cut -d : -f 1)

[ -z "$session" ] && exit 0

alacritty -e tmux attach -t "$session" 2> /dev/null
