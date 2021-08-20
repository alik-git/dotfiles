#!/bin/sh

# Make sure to put the your nas creds in the nas_creds file !!!
# Make sure to set your local user's uid and gid in the personal_config/nas_stuff/mnt-MyStuff.mount file !!
set -x

mkdir -p /mnt/MyStuff

cp /home/kuwajerw/repos/dotfiles/personal_config/nas_stuff/mnt-MyStuff.mount /etc/systemd/system/mnt-MyStuff.mount

cp /home/kuwajerw/repos/dotfiles/personal_config/nas_stuff/mnt-MyStuff.automount /etc/systemd/system/mnt-MyStuff.automount

. /home/kuwajerw/repos/dotfiles/personal_config/nas_stuff/nas_daemon_commands.sh
