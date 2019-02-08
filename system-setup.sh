#!/bin/bash
set -eux

envType="$1"
sysFirstInit="$2"

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

function configureShell()
{

touch ~/.bash_aliases

ALIASES=$(cat <<"EOF"

#####################
# Alias for running vscode in docker image from ~/Projects directory on host
alias code='sudo docker pull mikehathaway/qubes-dev:latest && sudo docker run -$

alias docker-node='sudo docker pull node && sudo docker run -it node'

alias dev='bash ~/Projects/system-setup/sytem-setup.sh dev false'
EOF
)

echo "${NPM_CONFIG}" >> ~/.bash_aliases
}




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


  # Only write to config files on first setup
  if [ $sysFirstInit == true ]
    then

    echo "Install dependencies"
    systemInit

    echo "Configuring NPM"
    configureNPM

    echo "Configring system aliases"
    configureShell

  fi  
fi


