~/.local/bin/morgue -d -f Pango -s slow ~/org/notes.md ~/org/uni.md > ~/tmp/agenda
notify-send -u low -t 0 -a morgue "$(cat ~/tmp/agenda)"
