#!/bin/sh

set -x

apt-get update  # To get the latest package lists

# installing apps 
apt install git -y
apt-get install vim -y
apt install build-essential -y
apt-get install gimp -y
apt install gnome-tweaks -y
apt install neofetch -y
apt install qbittorrent -y
apt-get install gparted -y
apt install python3-dev python3-pip python3-setuptools -y
apt-get install xclip -y
apt install snapd -y
apt install cifs-utils -y

# commented out for now
# pip3 install thefuck
# apt install thefuck -y

# website stuff
apt install ruby -y
apt-get install ruby-dev -y
apt install ruby-bundler -y

# snap packages
snap install vlc
snap install emacs
snap install slack --classic
snap install --classic code
snap install discord # sometimes doesn't update properly

