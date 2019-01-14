#!/bin/bash
set -eux

if [ $1 == 'dev' ]
  then

  # Install nodejs
  echo "Installing node"
  sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
      && sudo apt-get install -y nodejs

# Only write to config files on first setup
if [ $2 -eq true ]
  then

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

fi  

# Install truffle
echo "Starting installation of crypto tools"
npm install -g truffle ganache-cli

fi

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

    # Install shell  
    sudo apt-get install terminator
}

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
