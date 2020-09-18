#!/bin/sh
# read in the currently active tmux sessions
session=$(tmux list-sessions | dmenu -i -l 20 | cut -d : -f 1)

[ -z "$session" ] && exit 0

st -e tmux attach -t "$session" 2> /dev/null
