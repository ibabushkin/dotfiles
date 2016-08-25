#!/bin/zsh
# read in commonly used notifications
sort ~/dotfiles/alarm_cache | dmenu -p "time offset, message:" |
tr , "\n" | ((read -A line1; sleep $line1) &&
(read line2; notify-send -u critical -a alarm "$line2"))
