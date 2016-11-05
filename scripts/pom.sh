#!/bin/sh
pid=$(pidof spt)

if [[ $pid == "" ]]; then
  if [[ $1 == "-t" ]]; then
    spt
  fi
else
  if [[ $1 == "-t" ]]; then
    kill -s "TERM" $pid
    notify-send -a spt spt "stopped working!"
  elif [[ $1 == "-i" ]]; then
    kill -s "USR1" $pid
  elif [[ $1 == "-p" ]]; then
    kill -s "USR2" $pid && kill -s "USR1" $pid
  fi
fi
