#!/bin/sh
notify-send -t 0 -u low -a morgue "$(morgue -f pango -t slow -i ~/org/notes.md ~/org/uni.md)"
