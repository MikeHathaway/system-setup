#!/bin/bash
set -eux

sysInit = $1

if [ sysInit -eq true]
    then
        sudo echo "alias node='sudo docker pull node && sudo docker run -it node'" >> ~/.bashrc
        sudo echo `###################### 
        # Alias for running vscode in docker image
        alias code='sudo docker pull mikehathaway/qubes-dev:latest \ 
        && sudo docker run -d --rm -e "DISPLAY=$DISPLAY" \
        -v /tmp/.X11-unix:/tmp/.X11-unix \ 
        -v ~/Projects:/home/dev mikehathaway/qubes-dev:latest'` >> ~/.bashrc
fi