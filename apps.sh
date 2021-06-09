#!/bin/sh

# installing apps 
apt install git -y
git config --global user.name "Ali K"
git config --global user.email "ali.kuwajerwala@mail.utoronto.ca"
apt-get update  # To get the latest package lists
apt-get install vim -y
apt install build-essential -y
apt-get install gimp -y
snap install vlc -y
apt install gnome-tweaks -y
# apt install adwaita-icon-theme-full
apt-get install spotify-client -y
apt install neofetch -y
apt install qbittorrent -y
snap install emacs -y
apt-get install gparted -y
apt install python3-dev python3-pip python3-setuptools -y
pip3 install thefuck
apt install thefuck -y
apt-get install xclip -y

snap install slack --classic

# discord 
# snap install discord # commented out cause if you use snap to install discord it doesn't update properly you gotta go like snap refresh discord and its really annoying


# some settings changes 




# VSCode stuff 
snap install --classic code

# wesite stuff
apt install ruby -y
apt-get install ruby-dev -y
apt install ruby-bundler -y
# apt install software-properties-common apt-transport-https wget -y
# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
# add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# apt update
# apt install code -y


#etc.
