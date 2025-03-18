#!/bin/bash

set -x

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Get the repository root (one directory up from the script)
REPO_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# set and use local time on motherboard
# timedatectl set-local-rtc 1 --adjust-system-clock

# setup git user conifg
git config --global user.name "alik-git"
git config --global user.email "ali@kscale.dev"

COLORS="red green blue"
for COLOR in $COLORS
do
  echo "The Color is: ${COLOR}"
done

# # profile stuff
# mv ~/.profile "$REPO_ROOT/personal_config/defaults/.default_profile"
# ln -sv "$REPO_ROOT/personal_config/profile_stuff/.profile" ~

# # zshrc stuff
# mv ~/.zshrc "$REPO_ROOT/personal_config/defaults/.default_zshrc"
# ln -sv "$REPO_ROOT/personal_config/zshrc_stuff/.zshrc" ~

# # zshrc p10k stuff
# mv ~/.p10k.zsh "$REPO_ROOT/personal_config/defaults/.default_p10k_zsh"
# ln -sv "$REPO_ROOT/personal_config/zshrc_stuff/.p10k.zsh" ~

# bashrc stuff
mv ~/.bashrc "$REPO_ROOT/personal_config/defaults/.default_bashrc"
ln -sv "$REPO_ROOT/personal_config/bashrc_stuff/.bashrc" ~

# # vim stuff 
# mv ~/.vimrc "$REPO_ROOT/personal_config/defaults/.default_vimrc"
# ln -sv "$REPO_ROOT/personal_config/other/.vimrc" ~

# install thefuck
# if this fails you're probably missing the python requirements below (they're in the install apps script)
# sudo apt install python3-dev python3-pip python3-setuptools -y
# pip3 install thefuck --user -y
# pip3 install tldr























