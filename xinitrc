#!/bin/bash

# clipboard management
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# don't beep
which xset 2> /dev/null && xset -b

# merge in resources and keymaps
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
# [ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# start the window manager and some other stuff
~/dotfiles/scripts/control.sh start bar
~/dotfiles/scripts/control.sh start dunst
bgs -z ~/dotfiles/background.jpg &
swarp 0 900 &
sct 37000 &
RUST_BACKTRACE=1 RUST_LOG=debug exec gabelstaplerwm 2> ~/wm_log > ~/tmp/tagset_fifo
