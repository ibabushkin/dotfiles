if [ $1 = "init" ]; then
    out=$(amixer -c 1 get Master | grep "\[")
else
    out=$(amixer -c 1 set Master $1 | grep "\[")
fi

echo vol: $(echo $out | cut -d ' ' -f 4,6) > ~/tmp/alsa_fifo
