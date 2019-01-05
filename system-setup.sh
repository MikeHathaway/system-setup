#!/bin/bash
set -eux

dev = $1
crypto = $2

if [args -eq "dev"]
  then
    echo "Starting installation of development build tools"

    # Install Buildtools
    sudo apt-get install
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common 
      git  \
      build-essential \

    # Install shell  
    sudo apt-get install terminator

    # Install Docker
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) \
      stable"

    sudo apt-get update  

    sudo apt-get install
      docker-ce \ 
      docker-compose

    # Install nodejs
    sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
        && sudo apt-get install -y nodejs

    if [crypto -eq true]
      then
        echo "Starting installation of crypto tools"
        sudo npm install -g truffle    
    fi  
fi

function installDocker()
{
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) \
      stable"

    sudo apt-get update  

    sudo apt-get install
      docker-ce \ 
      docker-compose
}
