#!/bin/sh
if [ "$1" = "dummy" ]; then
    # access a dummy entry to load the key
    pass dummy > /dev/null 2>&1 && echo "+" > ~/tmp/gpg_status_fifo
else
    # read in the password store and use rofi to run pass on an entry from it
    find ~/.password-store -type f -name "*.gpg" |
    sed 's#.*\.password-store/##' | sed 's#\.gpg$##' |
    rofi -dmenu -n -i | (xargs pass -c && echo "+" > ~/tmp/gpg_status_fifo) ||
        notify-send -u critical -t 1000 -a pass "wrong passphrase"
fi
