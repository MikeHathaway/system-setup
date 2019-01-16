#!/bin/bash
set -eux


function systemInit()
{
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

  echo "Installing Shell"

  # Install shell  
  sudo apt-get install terminator
}


function configureNPM()
{
mkdir "${HOME}/.npm-packages"
sudo echo 'prefix=${HOME}/.npm-packages' >> ~/.npmrc

NPM_CONFIG=$(cat <<"EOF"

#####################
#NPM package configuration

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="${NPM_PACKAGES}/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command"
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
EOF
)

echo "${NPM_CONFIG}" >> ~/.bashrc
}











if [ $1 == 'dev' ]
  then

  ## Install nodejs
  # This is installed everytime the work vm starts up
  echo "Installing node"
  sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
      && sudo apt-get install -y nodejs

# Only write to config files on first setup
if [ $2 -eq true ]
  then

  echo "Initalizing System"
  systemInit

  echo "Configuring NPM"
  configureNPM

fi  

  # Install truffle
  echo "Starting installation of crypto tools"
  npm install -g truffle ganache-cli

fi


