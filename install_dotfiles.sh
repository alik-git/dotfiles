#!/bin/bash


COLORS="red green blue"
for COLOR in $COLORS
do
  echo "The Color is: ${COLOR}"
done

# bashrc stuff
rm -f ~/.bashrc
ln -sv ~/repos/dotfiles/.bashrc ~

# # vscode stuff
# # settings
# rm -f ~/.config/Code/User/settings.json
# ln -sv ~/dotfiles/Code/User/settings.json ~/.config/Code/User/

# # shortcuts
# rm -f ~/.config/Code/User/keybindings.json
# ln -sv ~/dotfiles/Code/User/keybindings.json ~/.config/Code/User/




# vim stuff 
rm -f ~/.vimrc
ln -sv ~/repos/dotfiles/.vimrc ~

























