#!/bin/sh
if [ "$1" = "init" ]; then
    out=$(amixer get Master | tail -n 1)
else
    out=$(amixer set Master "$1" | tail -n 1)
fi

if echo "$out" | grep "\[on\]"; then
    echo "vol: %{F#268bd2}$(echo "$out" | cut -d ' ' -f 6)" > ~/tmp/alsa_fifo
else
    echo "vol: %{F#ff0606}$(echo "$out" | cut -d ' ' -f 6)" > ~/tmp/alsa_fifo
fi

