#!/bin/sh
# read in the menu file and use rofi to run an entry from it
sed 's/,.*//' ~/dotfiles/menu | sort |
rofi -dmenu -i | xargs -I{} grep {}, ~/dotfiles/menu |
sed 's/.*,/exec /' | /bin/sh &
