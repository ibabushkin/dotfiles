#!/bin/sh

# setup a gpg-agent for SSH and OpenPGP key storage
# if this turns out to be not enough at some point, we can always just use something like
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --kill gpg-agent
eval "$(gpg-agent --daemon --enable-ssh-support -s)"

# default screen config
xrandr --output VGA1 --off

# clipboard management
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# fix our backlight
~/dotfiles/scripts/backlight_fix.sh

# don't beep
which xset > /dev/null && xset b off

# swap caps lock and escape
which setxkbmap > /dev/null && setxkbmap -option caps:swapescape

# start the window manager and some other stuff
~/dotfiles/scripts/control.sh restart bar
~/dotfiles/scripts/control.sh restart dunst
~/dotfiles/scripts/control.sh restart sct
~/dotfiles/scripts/control.sh restart wallpaper

swarp 0 900 &
RUST_BACKTRACE=1 RUST_LOG=debug exec gabelstaplerwm 2> ~/wm_log > ~/tmp/tagset_fifo
