# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000
# NOTE when HISTFILESIZE is set, history file is truncated immediately.
#      so it is commented out here.

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -al'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# NOTE
# the above settings are from /etc/skel/.bashrc on ubuntu 22.04.2 LTS (Jammy Jellyfish).
# only a few settings have bee changed.
# convention:
#     commented out bash code has no space after "#" (for the first line in a block).


HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%F-%H-%M "

# autojump
if [ -f /usr/share/autojump/autojump.sh ]; then
    . /usr/share/autojump/autojump.sh
fi

# append argument 1 to PATH if it is not present in PATH.
# I see this in /etc/profile on archlinux.
append_path () {
    # test argument 1.
    if [ ! -v 1 ]; then
        # argument 1 is not set
        # this is wrong usage of the function.
        # NOTE "-v" is a feature of bash. it seems not to be present in dash.
        return
    fi
    if [ -z "${1}" ]; then
        # argument 1 is "" (i.e., null).
        return
    fi

    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# local PATH
#PATH="$HOME/.local/bin:$PATH"
# "$HOME/.local/bin" would be added in .profile on debian.

# this is for emacs to get input method of Chinese
# also needed to properly show Chinese in ssh sessions.
#export LC_CTYPE=zh_CN.UTF-8

# ssh detection
if [ $SSH_TTY ] || [ $SSH_CLIENT ]; then
    PS1="(ssh) ${PS1}"
fi

#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  #export TERM=xterm-256color && exec tmux new -Asdefault
#  #export TERM=screen-256color
#  #exec tmux -2 new -Asdefault
#  # exec replace current session with a new one. so there would be no other shell to fall back to.
#  exec tmux new -Asdefault
#fi

# in order to use vim in ipython
export EDITOR=vim

# disable software flow control (by default, C-s stops terminal printing text).
stty -ixon

# more bash configuration.
# idea:
#   - the .bashrc file is kept unmodified.
#   - this bash_config.sh would be used to store more settings.
if [ -f ~/.config/bash_config.sh ]; then
    source ~/.config/bash_config.sh
fi
