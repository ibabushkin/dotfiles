#!/bin/sh
load=$(cat /proc/loadavg | cut -d ' ' -f 1-3)
temp=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))
echo "load: %{F#268bd2}[$load @ $temp°C]"
