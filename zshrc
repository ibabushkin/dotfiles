# .zshrc
# Mostly by Inokentiy Babushkin <inokentiy.babushkin@gmail.com>
# License: beerware.

# Basic zsh config.
umask 022
ZDOTDIR=${ZDOTDIR:-${HOME}}
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
for zshd in $(ls -A ${HOME}/.zsh/*); do
    source "${zshd}"
done

# make Ctrl-Shift-T work in termite
if [ "${TERM}" = 'xterm-termite' ]; then
    source /etc/profile.d/vte.sh
    __vte_osc7
fi

# make a temporary directory if necessary 
if [ ! -d "${TMP}" ]; then mkdir "${TMP}"; fi

# le features!

# awesome extended globbing
setopt extendedGlob

# zmv -  a command for renaming files by means of shell patterns
autoload -U zmv

# zargs, as an alternative to find -exec and xargs
autoload -U zargs

# gather version control info
autoload -Uz vcs_info

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
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

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

# prompt
setopt prompt_subst

# mode-aware arrow
function p_arrow {
  if [[ $KEYMAP = "vicmd" ]]; then
    echo "%F{magenta}➜%f"
  else
    echo "%F{cyan}➜%f"
  fi
}

# RPROMPT shows status info such as time and return code
function p_status {
  if [ $? -ne 0 ]; then
    echo "%F{red}[%?]%f%F{green}[%f%T%F{green}]%f "
  else
    echo "%F{green}[%f%T%F{green}]%f "
  fi
}

# colored path
function p_colored_path {
  local slash="%F{cyan}/%f"
  echo " ${${PWD/#$HOME/~}//\//$slash}"
}

# git info
function p_vcs {
  zstyle ':vcs_info:git*' formats " [%s:%F{green}%b%f]%F{red}%u%f%F{yellow}%c%f"
  zstyle ':vcs_info:git*' check-for-changes 1
  vcs_info
  echo $vcs_info_msg_0_
}

# environments:
#  - ssh
#  - virtualenv
#  - cabal sandbox

export VIRTUAL_ENV_DISABLE_PROMPT=1

function p_envs {
  # check for cabal sandbox in parent directories, recursively
  local cabal
  cabal=( (../)#cabal.sandbox.config(N) )

  local envs
  [[ -n $SSH_CLIENT ]]  && envs+="R"
  (( $#cabal ))         && envs+="H"
  [[ -n $VIRTUAL_ENV ]] && envs+="P"

  [[ -n $envs ]] && echo " %F{green}[%f$envs%F{green}]%f"
}

PROMPT='%F{blue}λ%f$(p_colored_path)$(p_envs)$(p_vcs) $(p_arrow) '
RPROMPT='$(p_status)'
