#!/bin/sh

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

pip3 install thefuck
apt install thefuck -y

# snap packages
snap install vlc -y
snap install emacs -y
snap install slack --classic -y
snap install --classic code -y 
snap install discord -y # sometimes doesn't update properly

# website stuff
apt install ruby -y
apt-get install ruby-dev -y
apt install ruby-bundler -y

# older stuff

# apt install software-properties-common apt-transport-https wget -y
# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
# add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# apt update
# apt install code -y


#etc.
