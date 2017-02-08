#!/bin/bash
# read in a place name
cat ~/dotfiles/weather_cache | sort | dmenu -y 20 -p location: | tr , "\n" |
xargs -I{} ~/.local/bin/hweather -a $(cat ~/hweather/openweathermap.id) -f Pango -u Metric -c {} -C {} |
sed -z "s/\n\n\n.*/\n/g" > ~/tmp/weather
notify-send -u low -t 0 -a hweather "$(cat ~/tmp/weather)"
