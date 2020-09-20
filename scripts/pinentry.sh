#!/bin/sh

if [ "$PINENTRY_USER_DATA" = "curses" ]; then
  exec pinentry-curses "$@"
else
  exec pinentry-gtk-2 "$@"
fi
