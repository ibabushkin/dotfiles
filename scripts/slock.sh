#!/bin/sh
gpgconf --kill gpg-agent
cmus-remote -Q | grep "status playing" 2> /dev/null
cmus_status=$?
[ $cmus_status -eq 0 ] && cmus-remote -u
~/dotfiles/scripts/pom.sh -p && slock && ~/dotfiles/scripts/pom.sh -p
[ $cmus_status -eq 0 ] && cmus-remote -u
