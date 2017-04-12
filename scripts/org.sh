#!/bin/sh
notify-send -t 0 -u low -a morgue "$(morgue -d -f pango -t slow -i -m timed ~/org/notes.md ~/org/uni.md)"
