#!/bin/zsh
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias dump='~/dotfiles/scripts/dump.sh'
alias control='~/dotfiles/scripts/control.sh'
alias bookmarks='~/dotfiles/scripts/bookmarks.sh'
alias reattach='~/dotfiles/scripts/reattach.sh'
alias cmus='cmus && echo "" > ~/tmp/cmus_fifo'
alias killgpg='gpgconf --kill gpg-agent && echo "" > ~/tmp/gpg_status_fifo'

if command -v colordiff > /dev/null 2>&1; then
    alias diff="colordiff -Nuar"
else
    alias diff="diff -Nuar"
fi

