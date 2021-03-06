#!/bin/sh
# read in commonly used notifications
line=$(sort ~/dotfiles/alarm_cache | rofi -dmenu -p "time offset, message:")
offset=$(echo "$line" | sed "s/,.*//")
message=$(echo "$line" | sed "s/.*,//")

sleep $offset
notify-send -u critical -a alarm "$message"
