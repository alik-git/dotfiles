# Get the directory where this script is located
DOTFILES_ROOT="/home/ali/repos/ksim_stuff/dotfiles"

source "$DOTFILES_ROOT/personal_config/defaults/.default_bashrc"


######################################
##### My Stuff #######################
######################################



# ### Add to Path ###
# # export PATH='/home/kuwajerw/.local/bin'
# export PATH="$HOME/.local/bin:$PATH"

### Prompt ###
if [ -f "$DOTFILES_ROOT/personal_config/bashrc_stuff/custom_bash_prompt.sh" ]; then
    . "$DOTFILES_ROOT/personal_config/bashrc_stuff/custom_bash_prompt.sh"
else
    echo "Warning: custom_bash_prompt.sh not found"
fi

### Aliases ###
if [ -f "$DOTFILES_ROOT/personal_config/profile_stuff/aliases.sh" ]; then
    . "$DOTFILES_ROOT/personal_config/profile_stuff/aliases.sh"
else
    echo "Warning: aliases.sh not found"
fi

### Functions ###
if [ -f "$DOTFILES_ROOT/personal_config/profile_stuff/functions.sh" ]; then
    . "$DOTFILES_ROOT/personal_config/profile_stuff/functions.sh"
else
    echo "Warning: functions.sh not found"
fi



###################
### Other Stuff ###
###################

# # This is where you put your hand rolled scripts (remember to chmod them)
# PATH="$HOME/bin:$PATH"

# Install Ruby Gems to ~/gems
# export GEM_HOME="$HOME/gems"
# export PATH="$HOME/gems/bin:$PATH"

# # Put stuff in PYTHONPATH
# export PYTHONPATH="${PYTHONPATH}:/home/kuwajerw/repos/gym_duckytown_fork_folder/gym-duckietown"

# # Mujoco Stuff
# export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/home/kuwajerw/.mujoco/mujoco210/bin"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/kuwajerw/.mujoco/mujoco200/bin"
# export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/nvidia"

# libGLEW stuff  old
# export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libGLEW.so"
# export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libGLEW.so"
#################
#################



# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/kuwajerw/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/kuwajerw/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/kuwajerw/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/kuwajerw/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# # export LD_LIBRARY_PATH=/usr/lib/cuda/lib64:$LD_LIBRARY_PATH
# # export LD_LIBRARY_PATH=/usr/lib/cuda/include:$LD_LIBRARY_PATH
# # export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-10.1/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
# # set PATH for cuda 10.1 installation
# if [ -d "/usr/local/cuda-10.1/bin/" ]; then
#     export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}
#     export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#     export LD_LIBRARY_PATH=/usr/local/cuda-10.2${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# fi

# # # CUDA stuff
# export PATH="/usr/local/cuda-12.2/bin:$PATH"
# export LD_LIBRARY_PATH="/usr/local/cuda-12.2/lib64:$LD_LIBRARY_PATH"

# export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
# # Interbotix Configurations

# # Interbotix Configurations

# # Interbotix Configurations

# # Interbotix Configurations
# source /home/kuwajerw/interbotix_ws/devel/setup.bash
# . "$HOME/.cargo/env"

# Test 11
