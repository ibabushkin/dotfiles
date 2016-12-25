load=$(cat /proc/loadavg | cut -d ' ' -f 1-3)
declare -i temp=$(cat /sys/class/thermal/thermal_zone0/temp)
echo "load: %{F#268bd2}[$load @ $((temp / 1000))°C]"
