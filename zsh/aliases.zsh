#!/bin/zsh
alias rmdir='rmdir -v'
alias cp='cp --reflink=auto'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

alias ssh='(ssh-add -L > /dev/null 2>&1 || ~/dotfiles/scripts/pass.sh dummy) && ssh'
alias mosh='(ssh-add -L > /dev/null 2>&1 || ~/dotfiles/scripts/pass.sh dummy) && mosh'

alias cmus='cmus && echo "" > ~/tmp/cmus_fifo'
alias hledger='hledger -f ~/org/hledger.journal'
alias cformat='clang-format -style=file'
alias killgpg='kill -HUP $(pidof gpg-agent) && echo "" > ~/tmp/gpg_status_fifo'
alias refreshgpg='gpg-connect-agent updatestartuptty /bye'

alias backlight='~/dotfiles/scripts/backlight_fix.sh'
alias bookmarks='~/dotfiles/scripts/bookmarks.sh'
alias control='~/dotfiles/scripts/control.sh'
alias dump='~/dotfiles/scripts/dump.sh'
alias reattach='~/dotfiles/scripts/reattach.sh'

if command -v colordiff > /dev/null 2>&1; then
    alias diff="colordiff -Nuar"
else
    alias diff="diff -Nuar"
fi
