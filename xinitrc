#!/bin/bash

# variables
userresources=~/.Xresources
usermodmap=~/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# clipboard management
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# don't beep
which xset 2> /dev/null && xset -b

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f $userresources ] && xrdb -merge $userresources
[ -f $usermodmap ] && xmodmap $usermodmap

# start the window manager and some other stuff
~/dotfiles/scripts/control.sh start bar
~/dotfiles/scripts/control.sh start dunst
bgs -z ~/dotfiles/background.jpg &
swarp 0 900 &
sct 37000 &
RUST_BACKTRACE=1 RUST_LOG=debug exec gabelstaplerwm 2> ~/wm_log > ~/tmp/tagset_fifo
