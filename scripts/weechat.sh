#!/bin/sh
if $(tmux has-session -t weechat); then
  tmux attach
else
  tmux new -s weechat weechat
fi
