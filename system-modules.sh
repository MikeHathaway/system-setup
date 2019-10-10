set -ex


function installDeps()
{
  echo "Starting installation of development build tools"

  echo "Updating repository list"
  sudo apt-get update

  echo "Creating symlink between https and http package installations"
  ln -s /usr/lib/apt/methods/http /usr/lib/apt/methods/https

  # Install Buildtools
  echo "Installing Buildtools"
  sudo apt-get install
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common 
    git  \
    build-essential \

  echo "Installing Shell"

  # Install tmux  
  sudo apt-get install tmux

  # Install Markdown preview dependencies
  sudo apt-get install grip xdotool

  # Install Python-dep
  sudo apt-get install python3-pip

  # Removed unneeded system modules
  sudo apt autoremove
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

echo "ADDING ALIASES"
ALIASES=$(cat <<"EOF"
#####################
# Alias for running vscode in docker image from ~/Projects directory on host
alias code='sudo docker pull mikehathaway/qubes-dev:latest && sudo docker run -$
alias docker-node='sudo docker pull node && sudo docker run -it node'
alias dev='bash ~/Projects/system-setup/sytem-setup.sh dev false'

# Add Colors
export PS1="\e[0;31m[\u@\h \W]\$ \e[m"
EOF
)
echo "${ALIASES}" >> ~/.bashrc

echo "UPDATING XTERM CONFIG"
XTERM_CONFIG=$(cat << "EOF"
xterm*faceName: Monospace
xterm*faceSize: 11
EOF
)
echo "${XTERM_CONFIG}" >> ~/.Xresources

echo "Merging Updates to ~/.Xresources" 
xrdb -merge ~/.Xresources
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

echo "${PLUGINS}" > ~/.vim/plugins.vim

touch ~/.vimrc 

echo "source ~/.vim/plugins.vim" > ~/.vim/.vimrc

# Install Vim PLugins
vim +PlugIntstall +qall
}




"$@"

