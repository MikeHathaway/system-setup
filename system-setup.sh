#!/bin/bash
set -ex

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

echo "${ALIASES}" >> ~/.bash_aliases
}


function configureVim()
{

sudo curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

touch ~/.vim/plugins.vim

PLUGINS=$(cat << "EOF"

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

call plug#end()
EOF
)

echo "${PLUGINS}" >> ~/.vim/plugins.vim

touch ~/.vim/.vimrc 

echo "so ~/.vim/plugins.vim" >> ~/.vim/.vimrc

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

  # Install react-native-cli
  npm i -g react-native-cli


  # Only write to config files on first setup
  if [ $sysFirstInit == true ]
    then

    echo "Install dependencies"
    systemInit
    
    echo "Configuring Vim"
    configureVim

    echo "Configuring NPM"
    configureNPM

    echo "Configring system aliases"
    configureShell

  fi  
fi

"$@"
