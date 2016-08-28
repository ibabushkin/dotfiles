#!/bin/sh
# read in the password store and use dmenu to run pass on an entry from it
find ~/.password-store -type f -name "*.gpg" |
sed 's#.*\.password-store/##' | sed 's#\.gpg$##' |
dmenu -y 20 -i | xargs pass -c
