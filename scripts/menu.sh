#!/bin/sh
# read in the menu file and use dmenu to run an entry from it
sed 's/,.*//' ~/dotfiles/menu | sort |
dmenu -y 20 -i | xargs -I{} grep {}, ~/dotfiles/menu |
sed 's/.*,/exec /' | /bin/sh &
