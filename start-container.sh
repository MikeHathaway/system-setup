#!/bin/bash
set -eux

# allow X11 access
xhost +local:docker

# start vscode
sudo docker run -d \
  -d \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v ${PWD}:/developer/project \
  -e DISPLAY=unix${DISPLAY} \
  -p 5000:5000 \
  --device /dev/snd \
  --name dev-vscode \
  vscode

sudo docker exec dev-vscode /developer/bin/start-vscode
