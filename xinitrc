#!/bin/sh

# variables
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
use_gabelstaplerwm=true

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

# prepare PATH for rust executables
PATH=$HOME/.multirust/toolchains/nightly/cargo/bin:$PATH

# start the window manager some other stuff
if [ $use_gabelstaplerwm ]; then
  dunst &
  bgs -z $HOME/dotfiles/background.jpg &
  bartender | lemonbar -p -g 1366x20+0+0 > /dev/null &
  RUST_LOG=debug exec gabelstaplerwm 2> ~/wm_log > ~/tmp/tagset_fifo
else
  exec /usr/bin/awesome
fi
