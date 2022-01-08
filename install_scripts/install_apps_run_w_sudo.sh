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
apt install python3-dev python3-pip python3-setuptools -y # this is for thefuck
apt-get install xclip -y
apt install snapd -y
apt install cifs-utils -y
apt install vlc -y
apt install ffmpeg -y
apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 -y
apt install curl git libgl1-mesa-dev libgl1-mesa-glx libglew-dev libosmesa6-dev software-properties-common net-tools unzip vim virtualenv wget xpra xserver-xorg-dev libglfw3-dev patchelf -y

# website stuff
apt install ruby -y
apt-get install ruby-dev -y
apt install ruby-bundler -y

# snap packages (just always have problems honestly)
# snap install vlc
# snap install emacs --classic
# snap install slack --classic
# snap install --classic code
# snap install discord # sometimes doesn't update properly

