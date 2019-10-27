#!/bin/bash
set -ex

sysFirstInit="$1"
shift

# Only write to config files on first setup
if [ $sysFirstInit == init ]
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

for i
  do

	if [ "$i" == 'crypto' ]
	  then

	  # Install truffle
	  echo "Starting installation of crypto tools"
	  npm install -g truffle ganache-cli 

	fi 

	# Install Javascript dev dependencies
	if [ "$i" == 'js' ]
	then

	  ## Install nodejs
	  # This is installed everytime the work vm starts up
	  echo "Installing node"
	  sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
		  && sudo apt-get install -y nodejs

	  # Install Typescript
	  npm i -g typescript
	  
	  # Install web3 client
	  npm i -g ethers
	fi	  

	# Install Python dev dependencies
	if [ "$i" == 'python' ]
	then
		
		# Install pip globally	
		sudo apt-get install python3-pip

		# Install virtualenv with path access
		sudo pip3 install virtualenv
	fi
  done	  
