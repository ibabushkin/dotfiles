#!/bin/sh
declare -i perc=$(cat /sys/class/power_supply/BAT0/capacity)
if [[ perc < 15 ]]; then
  notify-send -u critical -a battery "low charge! plug the cable!"
  echo "bat: %{F#ff0606}[$perc%]%{F#657b83}"
else
  echo "bat: [$perc%]"
fi
