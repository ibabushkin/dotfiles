#!/bin/sh
perc1=$(($(cat /sys/class/power_supply/BAT0/capacity)))

case $(cat /sys/class/power_supply/BAT0/status) in
    Charging)
        status1="+"
        ;;
    Unknown)
        status1="±"
        ;;
    Discharging)
        status1="-"
        ;;
    Full)
        status1=""
        ;;
    *)
        status1="e"
esac

if [ -d /sys/class/power_supply/BAT1 ]; then
    case $(cat /sys/class/power_supply/BAT0/status) in
        Charging)
            status2="+"
            ;;
        Unknown)
            status2="±"
            ;;
        Discharging)
            status2="-"
            ;;
        Full)
            status2=""
            ;;
        *)
            status2="e"
    esac
    bat2=" / $status2[$(cat /sys/class/power_supply/BAT1/capacity)%]"
fi

if [ $perc1 -lt 20 ] && [ $status1 != "+" ]; then
    notify-send -u critical -a battery "low charge! plug the cable or swap battery!"
    echo "bat: %{F#ff0606}$status1[$perc1%]$bat2"
elif [ $perc1 -lt 50 ]; then
    echo "bat: %{F#dddd06}$status1[$perc1%]$bat2"
else
    echo "bat: %{F#268bd2}$status1[$perc1%]$bat2"
fi
