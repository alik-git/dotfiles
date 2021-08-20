
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