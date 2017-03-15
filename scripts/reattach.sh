#!/bin/sh
# read in the currently active tmux sessions
session=$(tmux list-sessions | dmenu -n -i -y 20 -l 20 | cut -d : -f 1)

[ -z $session ] && exit 0

st tmux attach -t $session 2> /dev/null
