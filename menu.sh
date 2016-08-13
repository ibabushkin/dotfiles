sed 's/,.*//' menu | dmenu -i | xargs -I{} grep {} menu | sed 's/.*,//' | /bin/sh &
