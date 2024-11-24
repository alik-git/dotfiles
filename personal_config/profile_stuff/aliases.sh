# misc helpful shortcuts
alias h='cd ~'
alias ht='history'
alias sa='sudo apt install'

# python environments 
alias ca='conda activate'

# # getting to directories
# alias dot='cd ~/repos/dotfiles/'
# alias repos='cd ~/repos'

# reload bashrc
# if running bash
if [ -n "$BASH_VERSION" ]; then
    alias pop='echo "source ~/.bashrc"; source ~/.bashrc'
fi
# if running zsh
if [ -n "$ZSH_VERSION" ]; then
    alias pop='echo "source ~/.zshrc"; source ~/.zshrc'
fi

# fun apps 
# alias cat='batcat'

# DOCKER STUFF 
# alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
# alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'


# # Others' aliases 
# alias ipe='curl ipinfo.io/ip'
# alias ipi='ipconfig getifaddr en0'
# # This is GOLD for finding out what is taking so much space on your drives!
# alias bigfiles2="du -BM -S | sort -n -r |more"
# alias bigfiles="sudo du -aBM -d 1 . | sort -nr | head -20"
# alias dfc="df -h /dev/sda1 --output=source,fstype,size,used,avail,pcent"


# Older aliases 
# alias hu='conda activate rosp2; cd ~/csc477_ws/src/csc477_fall19/'
# alias air='cd ~/repos/ADRL/ADRL/; ./ADRL.sh -windowed -ResX=800 -ResY=600'
# alias drone='cd ~/repos/droneNavigationEquivariant/PythonClient/imitation_learning'
# alias dronem='cd ~/repos/droneNavigationEquivariant/PythonClient/multirotor'
# alias droneup='cd ~/repos/droneNavigationEquivariant/'
# alias runcarla='conda activate carla; cd ~/repos/carla/; ./CarlaUE4.sh -carla-server -benchmark -fps=30 -windowed -ResX=800 -ResY=600'
# alias gtd='ls -d $PWD/*'
# alias zip='for i in *; do echo '"'$PWD/''$i'/fromImage70.pt",'; done'
# logrotate -s ~/terminal_logs/logrotate.status /home/kuwajerw/repos/dotfiles/logging_stuff/terminal_logs.conf
# @daily /usr/sbin/logrotate -s /home/kuwajerw/terminal_logs/logrotate.status /home/kuwajerw/terminal_logs.conf
# 1   5   cleanlogs.daily   /home/kuwajerw/repos/dotfiles/logging_stuff/remove_old_logs.sh
# Show me the size (sorted) of only the folders in this directory
# alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
# alias ras='cd ~/repos/Neighborhood/; ./AirSimNH.sh -windowed -ResX=800 -ResY=600'
# alias eq='cd ~/repos/equivariantRepresentations; conda activate carla'

# website stuff
# alias web='cd ~/repos/alik-git.github.io/'
# alias pweb='cd ~/repos/alik-git.github.io/; bundle exec jekyll serve --livereload'
# alias pwebl='cd ~/repos/alik-git.github.io/; yes | ./bin/deploy --user; bundle exec jekyll serve --livereload'
# temp
# alias lrp='cd /home/kuwajerw/repos/self-play-learning/experiments/dpn-minisim/supervised-model;ca lrp;c'
# # misc helpful shortcuts
# alias l='ls -aCFlh'
# alias lsd="ls -alF | grep /$"
# Show me the size (sorted) of only the folders in this directory
# alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

# alias ras='cd ~/repos/Neighborhood/; ./AirSimNH.sh -windowed -ResX=800 -ResY=600'
# alias eq='cd ~/repos/equivariantRepresentations; conda activate carla'