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
HISTSIZE=1000
HISTFILESIZE=2000

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \n$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\\n$ '
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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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


######################################
##### My Stuff #######################
######################################

###############
### Aliases ###
###############

# misc helpful shortcuts
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CFlh'

alias lsd="ls -alF | grep /$"

alias c='clear'
alias h='cd ~'
alias ht='history'


# python environments 
alias ca='conda activate'

# getting to directories
alias dot='cd ~/repos/dotfiles/'
alias repos='cd ~/repos'

# website stuff
alias web='cd ~/repos/alik-git.github.io/'
alias pweb='cd ~/repos/alik-git.github.io/; bundle exec jekyll serve --livereload'
alias pwebl='cd ~/repos/alik-git.github.io/; yes | ./bin/deploy --user; bundle exec jekyll serve --livereload'

# reload bashrc
alias pop='echo "source ~/.bashrc"; source ~/.bashrc'

# Path related aliases
# adding stuff to python path
# export PYTHONPATH="${PYTHONPATH}:/home/kuwajerw/repos/hylaa"
# adding stuff to matlab path
#alias mat='/home/kuwajerw/repos/MATLAB/R2020a/bin/matlab'

# Others' aliases 
alias ipe='curl ipinfo.io/ip'
alias ipi='ipconfig getifaddr en0'
# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -BM -S | sort -n -r |more"
alias dsp="sudo du -aBM -d 1 . | sort -nr | head -20"
alias dfc="df -h /dev/sda1 --output=source,fstype,size,used,avail,pcent"

# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

alias ras='cd ~/repos/Neighborhood/; ./AirSimNH.sh -windowed -ResX=800 -ResY=600'
alias eq='cd ~/repos/equivariantRepresentations; conda activate carla'

# Older aliases 
# alias hu='conda activate rosp2; cd ~/csc477_ws/src/csc477_fall19/'
# alias air='cd ~/repos/ADRL/ADRL/; ./ADRL.sh -windowed -ResX=800 -ResY=600'
# alias drone='cd ~/repos/droneNavigationEquivariant/PythonClient/imitation_learning'
# alias dronem='cd ~/repos/droneNavigationEquivariant/PythonClient/multirotor'
# alias droneup='cd ~/repos/droneNavigationEquivariant/'
# alias runcarla='conda activate carla; cd ~/repos/carla/; ./CarlaUE4.sh -carla-server -benchmark -fps=30 -windowed -ResX=800 -ResY=600'
# alias gtd='ls -d $PWD/*'
# alias zip='for i in *; do echo '"'$PWD/''$i'/fromImage70.pt",'; done'

###################
### Other Stuff ###
###################

# This is where you put your hand rolled scripts (remember to chmod them)
PATH="$HOME/bin:$PATH"

# Something to make "thefuck" work ?
# eval "$(thefuck --alias)"

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

#################
### Functions ###
#################

# Go up x number of directories
u(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}
	


# Search command line history for x
hg(){
    search_term=$1
    history | grep $search_term
}

