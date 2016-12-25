#!/bin/sh
if [ $1 = "init" ]; then
    out=$(amixer -c 1 get Master | grep "\[")
else
    out=$(amixer -c 1 set Master $1 | grep "\[")
fi

if [[ "$out" =~ "[on]" ]]; then
    echo "vol: %{F#268bd2}$(echo $out | cut -d ' ' -f 4)" > ~/tmp/alsa_fifo
else
    echo "vol: %{F#ff0606}$(echo $out | cut -d ' ' -f 4)" > ~/tmp/alsa_fifo
fi

