#!/bin/sh

set -x

cd /tmp

wget -O "teamviewer_amd64.deb" "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -q --show-progress

# gzip -d 'FoxitReader_version_Setup.run.tar.gz'

# OUTPUT=$(tar xvf 'FoxitReader_version_Setup.run.tar')

# ./${OUTPUT}

sudo dpkg -i "teamviewer_amd64.deb"


