#!/bin/sh
cmus-remote -Q | grep "status playing"
cmus_status=$?
[[ $cmus_status -eq 0 ]] && cmus-remote -u
~/dotfiles/scripts/pom.sh -p && slock && ~/dotfiles/scripts/pom.sh -p
[[ $cmus_status -eq 0 ]] && cmus-remote -u
