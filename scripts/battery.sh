#!/bin/sh
perc=$(($(cat /sys/class/power_supply/BAT0/capacity)))

case $(cat /sys/class/power_supply/BAT0/status) in
    Charging)
        status="+"
        ;;
    Unknown)
        status="±"
        ;;
    Discharging)
        status="-"
        ;;
    Full)
        status=""
        ;;
    *)
        status="e"
esac

if [ $perc -lt 20 -a $status != "+" ]; then
    notify-send -u critical -a battery "low charge! plug the cable!"
    echo "bat: %{F#ff0606}$status[$perc%]"
elif [ $perc -lt 50 ]; then
    echo "bat: %{F#dddd06}$status[$perc%]"
else
    echo "bat: %{F#268bd2}$status[$perc%]"
fi
