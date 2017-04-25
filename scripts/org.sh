#!/bin/sh
if [ "$1" = "full" ]; then
    mode="both"
else
    mode="timed"
fi

files="$HOME/org/notes.md $HOME/org/uni.md"

notify-send -t 0 -u low -a morgue "$(morgue -m $mode -f pango -t slow -i $files)"
