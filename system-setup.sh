#!/bin/bash
set -ex

envType="$1"
sysFirstInit="$2"

if [ $envType == 'dev' ]
  then

  ## Install nodejs
  # This is installed everytime the work vm starts up
  echo "Installing node"
  sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
      && sudo apt-get install -y nodejs

  # Install truffle
  echo "Starting installation of crypto tools"
  npm install -g truffle ganache-cli

  # Install react-native-cli
  npm i -g react-native-cli


  # Only write to config files on first setup
  if [ $sysFirstInit == true ]
    then

    echo "Install dependencies"
    bash ./system-modules.sh installDeps
    
    echo "Configuring Vim"
    bash ./system-modules.sh configureVim

    echo "Configuring NPM"
    bash ./system-modules.sh configureNPM

    echo "Configring system aliases"
    bash ./system-modules.sh configureShell

  fi  
fi
