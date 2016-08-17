#!/bin/zsh
# read in commonly used notifications
cat ~/dotfiles/alarm_cache | sort | dmenu -p "time offset, message:" |
tr , "\n" | ((read -A line1; sleep $line1) &&
(read line2; notify-send -u critical -a alarm "$line2"))

