#!/bin/sh

set -x


cd /tmp

# download compressed mujoco binary. Found from here https://github.com/openai/mujoco-py#install-mujoco

wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz -q --show-progress

mkdir -p ~/.mujoco

tar -xvf mujoco210-linux-x86_64.tar.gz -C ~/.mujoco

