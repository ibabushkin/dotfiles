# .zshrc
# Mostly by Inokentiy Babushkin <twk@twki.de>
# License: beerware.

# Basic zsh config.
umask 022
ZDOTDIR=${ZDOTDIR:-${HOME}}
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"

source $HOME/dotfiles/z/z.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
for zshd in $(ls -A ${HOME}/.zsh/*); do
    source "${zshd}"
done

# make a temporary directory if necessary 
if [ ! -d "${TMP}" ]; then mkdir "${TMP}"; fi

# le features!

# awesome extended globbing
setopt extended_glob

# zmv -  a command for renaming files by means of shell patterns
autoload -U zmv

# zargs, as an alternative to find -exec and xargs
autoload -U zargs

# gather version control info
autoload -Uz vcs_info

# don't. fucking. beep.
setopt nobeep

# turn on command substitution in the prompt
# (and parameter expansion and arithmetic expansion)
setopt promptsubst

# Control-x-e to open current line in $EDITOR, awesome when writing
# functions or editing multiline commands
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# completion
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{blue}%d%f%u'

# if running as root and nice >0, renice to 0
if [ "$USER" = 'root' ] && [ "$(cut -d ' ' -f 19 /proc/$$/stat)" -gt 0 ]; then
    renice -n 0 -p "$$" && echo "# Adjusted nice level for current shell to 0."
fi

# ignore lines prefixed with '#'
setopt interactivecomments

# ignore duplicate in history
setopt hist_ignore_dups

# prevent record in history entry if preceding them with at least one space
setopt hist_ignore_space

# some stuff to sync different terminal windows
setopt share_history inc_append_history extended_history

# nobody needs flow control anymore, troublesome feature
setopt noflowcontrol

# keys
bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^J" history-beginning-search-forward
bindkey "^[[B" history-beginning-search-forward
bindkey "^K" history-beginning-search-backward 
bindkey "^[[A" history-beginning-search-backward 
bindkey "^O" accept-line
bindkey -M vicmd "^O" accept-line
bindkey -M viins "jj" vi-cmd-mode

# better vi mode
bindkey -v

function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=40

# alert file warning
if [ -f ~/.alert ]; then echo '>>> Check ~/.alert'; fi

# colors for ls
eval $(dircolors ~/.dircolors)

# mode-aware arrow
function p_arrow {
    if [[ $KEYMAP = "vicmd" ]]; then
        echo "%{%F{magenta}%B%}>%{%b%f%}"
    else
        echo "%{%F{blue}%B%}>%{%b%f%}"
    fi
}

# status info such as time and return code
function p_status {
    local res=$?
    if [ $res -ne 0 ]; then
        echo "%{%F{red}%}[$res]%{%f%F{blue}%}-%{%f%F{green}%}[%{%f%}%T%{%F{green}%}]%{%f%}"
    else
        echo "%{%F{green}%}[%{%f%}%T%{%F{green}%}]%{%f%}"
    fi
}

# git info
function p_vcs {
    zstyle ':vcs_info:git*' formats "%{%F{blue}%}-%{%f%}[%s:%{%B%F{green}%}%b%{%%b%f%}]%{%F{red}%}%u%{%f%F{yellow}%}%c%{%f%}"
    zstyle ':vcs_info:git*' check-for-changes 1
    vcs_info
    echo $vcs_info_msg_0_
}

function precmd {
    s="$(p_status)"
    FILLBAR=""
    PWDLEN=""

    slash="%{%F{blue}%}%{/%f%}"
    current_path="${PWD/#$HOME/~}"

    local str="┌($current_path)$(p_vcs)$s¬"
    # filter prompt expansion directives for length calculation
    local zero='%([BSUbfksu]|([FBK]|){*})'
    local size=${#${(S%%)str//$~zero/}}

    if [[ $size -gt $COLUMNS ]]; then
        ((PWDLEN=$COLUMNS - $size - 1))
    else
        FILLBAR="%{%F{blue}%}\${(l.($COLUMNS - $size)..-.)}%{%f%}"
    fi

    echo ""
}

PROMPT='\
%{%F{blue}%},%{%f%}(%$PWDLEN<...<${${current_path}//\//$slash}%<<)$(p_vcs)${(e)FILLBAR}$s%{%F{blue}%}¬
\`-%{%f%}$(p_arrow) '
