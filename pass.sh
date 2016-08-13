# read in the password store and use dmenu to run pass on an entry from it
find $HOME/.password-store -type f -name "*.gpg" |
sed 's#.*\.password-store/##' | sed 's#\.gpg$##' |
dmenu -i | xargs pass -c
