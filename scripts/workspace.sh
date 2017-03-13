#!/bin/sh
line=$(sed 's/,.*//' ~/dotfiles/workspace_cache | sort |
dmenu -n -i -y 20 | xargs -I{} grep {}, ~/dotfiles/workspace_cache)

[ -z $line ] && exit 0

workspace=$(echo $line | sed 's/,.*//')
path=$(echo $line | sed 's/.*,//')

st tmux new -s "${workspace}-0" -c $path &
st tmux new -s "${workspace}-1" -c $path &
exec st tmux new -s "${workspace}-2" -c $path
