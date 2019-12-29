#!/bin/sh
apt-get update  # To get the latest package lists
apt-get install vim -y
apt install build-essential -y
apt-get install gimp -y
snap install vlc -y
apt-get install spotify-client -y
apt install neofetch -y
sudo -H pip install thefuck -y



apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt update
apt install code -y


#etc.