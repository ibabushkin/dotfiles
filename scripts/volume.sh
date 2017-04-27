#!/bin/sh
if [ "$1" = "init" ]; then
    out=$(amixer get Master | tail -n 1)
else
    out=$(amixer set Master "$1" | tail -n 1)
fi

if echo "$out" | grep "\[on\]" > /dev/null; then
    echo "vol: %{F#6684e1}$(echo "$out" | cut -d ' ' -f 6)" > ~/tmp/alsa_fifo
else
    echo "vol: %{F#d73737}$(echo "$out" | cut -d ' ' -f 6)" > ~/tmp/alsa_fifo
fi

