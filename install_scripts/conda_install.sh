#!/bin/sh

set -x

# Go to home directory
cd ~

cd /tmp

# You can change what anaconda version you want at 
# https://repo.continuum.io/archive/
curl -Ok https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh

chmod +x Anaconda3-2021.05-Linux-x86_64.sh

bash Anaconda3-2021.05-Linux-x86_64.sh

conda update conda