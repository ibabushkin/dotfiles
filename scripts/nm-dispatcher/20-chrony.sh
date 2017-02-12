#!/bin/sh

if [ "$2" = "up" ]; then
    chronyc online
elif [ "$2" = "down" ]; then
    chronyc offline
fi > /dev/null
