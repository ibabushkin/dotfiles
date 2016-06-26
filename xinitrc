#!/bin/sh

# variables
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# language settings
export LANG=en_US.UTF-8

# clipboard management
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# don't beep
xset -b

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f $userresources ] && xrdb -merge $userresources
[ -f $usermodmap ] && xmodmap $usermodmap

# start the window manager:
exec /usr/bin/awesome