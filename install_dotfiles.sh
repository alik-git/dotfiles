#!/bin/bash


COLORS="red green blue"
for COLOR in $COLORS
do
  echo "The Color is: ${COLOR}"
done

# bashrc stuff
rm ~/.bashrc
ln -sv ~/Projects/dotfiles/.bashrc ~

# vscode stuff
# settings
rm ~/.config/Code/User/settings.json
ln -sv ~/Projects/dotfiles/Code/User/settings.json ~/.config/Code/User/

# shortcuts
rm ~/.config/Code/User/keybindings.json
ln -sv ~/Projects/dotfiles/Code/User/keybindings.json ~/.config/Code/User/
