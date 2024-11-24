# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# uncommenting this causes issues with recursive calling cycles
# because .bashrc and .profile both call each other
# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

######################################
##### My Stuff #######################
######################################

# echo "Running Ali's .profile config"

### Aliases ###
. ~/repos/dotfiles/personal_config/profile_stuff/aliases.sh

### Functions ###
.  ~/repos/dotfiles/personal_config/profile_stuff/functions.sh

### Logging Stuff ###
# . ~/repos/dotfiles/logging_stuff/start_logging.sh

###################
### Other Stuff ###
###################

# # Install Ruby Gems to ~/gems
# export GEM_HOME="$HOME/gems"
# export PATH="$HOME/gems/bin:$PATH"

# # Put stuff in PYTHONPATH
# export PYTHONPATH="${PYTHONPATH}:/home/kuwajerw/repos/gym_duckytown_fork_folder/gym-duckietown" catkin_make -DPYTHON_EXECUTABLE=/home/kuwajerw/anaconda3/bin/python

# # # ROS stuff
# source /opt/ros/noetic/setup.bash
# export ROS_IP=172.19.0.183
# export ROS_MASTER_URI=http://172.19.0.102:11311

# # Mujoco Stuff
# export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/home/kuwajerw/.mujoco/mujoco210/bin"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/kuwajerw/.mujoco/mujoco200/bin"
# export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/nvidia"

# libGLEW stuff 
# export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libGLEW.so"
# export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libGLEW.so"



# #################
# #################
# . "$HOME/.cargo/env"
