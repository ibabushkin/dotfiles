#!/bin/sh
# read in the menu file and use dmenu to run an entry from it
sed 's/,.*//' ~/dotfiles/menu | sort |
dmenu -n -i -y 20 | xargs -I{} grep {}, ~/dotfiles/menu |
sed 's/.*,/exec /' | /bin/sh &
