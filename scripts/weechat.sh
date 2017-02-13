#!/bin/sh
if [ "$1" != "--remote" ]; then
    if $(tmux has-session -t weechat); then
        exec tmux attach
    else
        exec tmux new -s weechat weechat
    fi
else
    export TERM=xterm-256color
    ssh -t toaster '~/weechat.sh'
fi
