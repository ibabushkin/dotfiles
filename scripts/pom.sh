#!/bin/sh
pid=$(pidof spt)

if [[ $1 == "-i" ]]; then
  kill -s "USR1" $pid
elif [[ $1 == "-p" ]]; then
  kill -s "USR2" $pid
  kill -s "USR1" $pid
elif [[ $1 == "-t" ]]; then
  if [[ $pid != "" ]]; then
    kill -s "TERM" $pid
    notify-send -a spt spt "stopped working!"
  else
    spt
  fi
fi
