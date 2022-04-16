#!/bin/bash

set -x

# set and use local time on motherboard
timedatectl set-local-rtc 1 --adjust-system-clock

# setup git user conifg
git config --global user.name "Ali K"
git config --global user.email "alihusein.kuwajerwala@umontreal.ca"

COLORS="red green blue"
for COLOR in $COLORS
do
  echo "The Color is: ${COLOR}"
done

# profile stuff
mv ~/.profile ~/repos/dotfiles/personal_config/defaults/.default_profile
ln -sv ~/repos/dotfiles/personal_config/profile_stuff/.profile ~


# bashrc stuff
mv ~/.bashrc ~/repos/dotfiles/personal_config/defaults/.default_bashrc
ln -sv ~/repos/dotfiles/personal_config/bashrc_stuff/.bashrc ~


# vim stuff 
mv ~/.vimrc ~/repos/dotfiles/personal_config/defaults/.default_vimrc
ln -sv ~/repos/dotfiles/personal_config/other/.vimrc ~

# install thefuck
# if this fails you're probably missing the python requirements below (they're in the install apps script)
# sudo apt install python3-dev python3-pip python3-setuptools -y
pip3 install thefuck --user -y
pip3 install tldr























