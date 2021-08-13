#!/bin/bash

# setup git user conifg
git config --global user.name "Ali K"
git config --global user.email "ali.kuwajerwala@mail.utoronto.ca"

COLORS="red green blue"
for COLOR in $COLORS
do
  echo "The Color is: ${COLOR}"
done

# bashrc stuff
mv ~/.bashrc ~/repos/dotfiles/personal_config/defaults/.default_bashrc
ln -sv ~/repos/dotfiles/personal_config/.bashrc ~


# vim stuff 
mv ~/.vimrc ~/repos/dotfiles/personal_config/defaults/.default_vimrc
ln -sv ~/repos/dotfiles/personal_config/.vimrc ~

























