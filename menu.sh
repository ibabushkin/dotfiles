# read in the menu file and use dmenu to run an entry from it
sed 's/,.*//' $HOME/dotfiles/menu | sort |
dmenu -i | xargs -I{} grep {} $HOME/dotfiles/menu |
sed 's/.*,/exec /' | /bin/sh &
