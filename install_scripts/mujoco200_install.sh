#!/bin/sh

set -x

mkdir ~/.mujoco
cd ~/.mujoco
wget https://www.roboti.us/download/mujoco200_linux.zip
unzip mujoco200_linux.zip
mv mujoco200_linux mujoco200
rm mujoco200_linux.zip
wget -O mjkey.txt https://github.com/milarobotlearningcourse/ift6163_homeworks/blob/master/hw1/mjkey.txt?raw=true


# you can turn this off if you want
# echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/kuwajerw/.mujoco/mujoco200/bin' >> ~/.bashrc 