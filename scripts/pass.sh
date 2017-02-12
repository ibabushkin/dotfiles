#!/bin/bash
# read in the password store and use dmenu to run pass on an entry from it
find ~/.password-store -type f -name "*.gpg" |
sed 's#.*\.password-store/##' | sed 's#\.gpg$##' |
dmenu -n -i -y 20 | xargs pass -c ||
    notify-send -u critical -t 1000 -a pass "wrong passphrase"
