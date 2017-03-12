#!/bin/sh
sed 's/,.*//' ~/dotfiles/workspace_cache | sort |
dmenu -n -i -y 20 | xargs -I{} grep {}, ~/dotfiles/workspace_cache |
sed 's/.*,/exec st tmux new -c /' | /bin/sh &
