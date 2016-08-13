# read in the menu file and use dmenu to run an entry from it
sed 's/,.*//' menu | sort |
dmenu -i | xargs -I{} grep {} menu |
sed 's/.*,/exec /' | /bin/sh &
