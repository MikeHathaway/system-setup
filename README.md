# Qubes Setup
This is a guide to setting up a development environment in QubesOS v4

## Setting up SSH
1. [Initalize Split SSH](https://deniszanin.com/using-split-ssh-gpg-in-qubes-os/)
2. [Add public key to Github / Remote](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)
3. [OPTIONAL: Signing commits with Split-GPG](https://deniszanin.com/using-git-in-qubes-4-split-ssh-split-gpg/) 

## Setting Up Docker in Qubes: 
1. [Add GPG key to TemplateVM repository list](https://www.qubes-os.org/doc/multimedia/)
2. [Install Docker CE in TemplateVM](https://docs.docker.com/install/linux/docker-ce/debian/#set-up-the-repository)
3. Reboot TemplateVM
4. Start AppVM
5. Build Docker Image encapsulating development environment
* Dockerfile Inspired by: https://github.com/Joengenduvel/docker-vscode/blob/master/Dockerfile

## Running Docker in Qubes:
1. [Add volume for sharing files between container and host VM](https://www.digitalocean.com/community/tutorials/how-to-share-data-between-the-docker-container-and-the-host)
2. Start Docker Container: `sudo docker run -d /
				--rm -e "DISPLAY=$DISPLAY" /
				-v /tmp/.X11-unix:/tmp/.X11-unix /
				-v ~/Projects:/home/dev code`
3. [Persist container images]
4. OPTIONAL: Alias Docker Run Command
* Add an entry to ~/.bashrc file pointing at the previous docker run command: `alias code='sudo docker run...'`

### Install Scripts
* Pass flag indicating whether this during an appVM's first configuration
- `chmod +x ./system-setup.sh && ./system-setup.sh init `
- On subsequent startups, can siple execute `dev <crypto|js|python>` list of arguments

### Setting up Vim
- List of plugins:  https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9

### Setup Trezor
https://github.com/trezor/trezor-core/issues/167
https://wiki.trezor.io/Qubes_OS


### Install Steam
https://forums.whonix.org/t/playing-dota2-with-torified-steamos-by-qubes-whonix/6584
