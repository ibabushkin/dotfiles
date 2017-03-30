#!/bin/sh

if ( [ "$2" = "up" ] || [ "$2" = "down" ] ) && [ "$1" != "personal" ]; then
    tincd -n personal -k
    sleep .2
    tincd -n personal
fi
