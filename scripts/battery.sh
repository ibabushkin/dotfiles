#!/bin/bash
declare -i perc=$(cat /sys/class/power_supply/BAT0/capacity)
if [[ perc < 20 ]]; then
    notify-send -u critical -a battery "low charge! plug the cable!"
    echo "bat: %{F#ff0606}[$perc%]"
elif [[ perc < 50 ]]; then
    echo "bat: %{F#dddd06}[$perc%]"
else
    echo "bat: %{F#268bd2}[$perc%]"
fi
