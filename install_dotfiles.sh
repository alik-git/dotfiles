#!/bin/bash


COLORS="red green blue"
for COLOR in $COLORS
do
  echo "The Color is: ${COLOR}"
done

rm ~/.bashrc
ln -sv ~/Projects/dotfiles/.bashrc ~


