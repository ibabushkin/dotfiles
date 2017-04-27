#!/bin/sh
load=$(cut -d ' ' -f 1-3 /proc/loadavg)
temp=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))
echo "load: %{F#6684e1}[$load @ $temp°C]"
