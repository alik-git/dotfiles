#!/bin/sh

set -x

apt-get update  # To get the latest package lists

cd /tmp
wget https://zoom.us/client/latest/zoom_amd64.deb

apt install ./zoom_amd64.deb -y


