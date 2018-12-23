#!/bin/bash
set -eux

dev = $1
crypto = $2

if [args -eq "dev"]
  then
    echo "Starting installation of development build tools"

    # Install Buildtools
    sudo apt-get install 
      git  \
      build-essential \ 
      terminator

    # Install nodejs
    sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
        && sudo apt-get install -y nodejs

    if [crypto -eq true]
      then
        echo "Starting installation of crypto tools"
        sudo npm install -g truffle    
    fi  
fi


