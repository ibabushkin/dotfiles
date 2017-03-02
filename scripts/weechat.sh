#!/bin/sh
if $(tmux has-session -t weechat); then
    exec tmux attach
else
    exec tmux new -s weechat weechat
fi
