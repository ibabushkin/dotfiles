#!/bin/sh

# variables
userresources=~/.Xresources
usermodmap=~/.Xmodmap
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
PATH=~/.multirust/toolchains/nightly/cargo/bin:~/.local/bin:$PATH

# start the window manager and some other stuff
if [ $use_gabelstaplerwm ]; then
  ~/dotfiles/scripts/control.sh start bar
  ~/dotfiles/scripts/control.sh start dunst
  bgs -z ~/dotfiles/background.jpg &
  swarp 0 768 &
  RUST_LOG=debug exec gabelstaplerwm 2> ~/wm_log > ~/tmp/tagset_fifo
else
  exec /usr/bin/awesome
fi
