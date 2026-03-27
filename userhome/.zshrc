# NOTE based on /etc/zsh/newuser.zshrc.recommended.
# Set up the prompt

autoload -Uz promptinit
promptinit
prompt redhat
# [exit_status], if exit status is not 0.
# (timestamp), 24-hour format.
# user@host:path
# % for normal user, # for root.
PROMPT='%(?..[%?] )(%T) %F{green}%n%f@%F{red}%m%f:%F{blue}%~%f%# '
# ssh detection
if [ "$SSH_TTY" ] || [ "$SSH_CLIENT" ]; then
    PS1="${PS1/\(%T\)/(ssh) (%T)}"
fi

setopt histignoredups
setopt histignorespace
setopt histreduceblanks
# for timestamp in history
setopt extendedhistory

WORDCHARS=${WORDCHARS//\//}

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Save history to ~/.zsh_history:
HISTSIZE=40000
SAVEHIST=40000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# it seems necessary
PATH="$HOME/.local/bin:$PATH"

# disable software flow control (by default, C-s stops terminal printing text).
stty -ixon

if [ -f ~/.config/zsh_config.zsh ]; then
    source ~/.config/zsh_config.zsh
fi

if [ -f ~/.config/zsh_functions.zsh ]; then
    source ~/.config/zsh_functions.zsh
fi


# aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias llh='ls -lh'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias py='python3'

alias emc='emacsclient'
alias emct='emacsclient -t'
alias emcn='emacsclient -n'

alias rsync='rsync -e "ssh -o ClearAllForwardings=yes"'
