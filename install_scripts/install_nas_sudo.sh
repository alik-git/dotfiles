#!/bin/sh

# Step 1: Actually connect to the NAS manually first. It should be visible on tank.local
# Step 2: Make sure to create a nas_creds file using the nas_creds_examle file

# Maybe needed: Make sure to set your local user's uid and gid in the personal_config/nas_stuff/mnt-MyStuff.mount file !!
set -x

mkdir -p /mnt/MyStuff

cp /home/kuwajerw/repos/dotfiles/personal_config/nas_stuff/mnt-MyStuff.mount /etc/systemd/system/mnt-MyStuff.mount

cp /home/kuwajerw/repos/dotfiles/personal_config/nas_stuff/mnt-MyStuff.automount /etc/systemd/system/mnt-MyStuff.automount

. /home/kuwajerw/repos/dotfiles/personal_config/nas_stuff/nas_daemon_commands.sh
