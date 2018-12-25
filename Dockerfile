FROM ubuntu:18.04

MAINTAINER Mike Hathaway

ENV LANG=C.UTF-8 \ 
DEBIAN_FRONTEND=noninteractive \ 
DEBCONF_NONINTERACTIVE_SEEN=true \ 
VSCODE=https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable

# get add-apt-repository
RUN apt-get update
RUN apt-get -y --no-install-recommends install software-properties-common curl gnupg \
apt-transport-https

# add nodejs ppa
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# update apt cache
RUN apt-get update

# vscode dependencies
RUN apt-get -y --no-install-recommends install libc6-dev libgtk2.0-0 libgtk-3-0 libpango-1.0-0 libcairo2 libfontconfig1 libgconf2-4 libnss3 libasound2 libxtst6 unzip libglib2.0-bin libcanberra-gtk-module libgl1-mesa-glx curl build-essential gettext libstdc++6 software-properties-common wget git xterm automake libtool autogen nodejs libnotify-bin aspell aspell-en htop git emacs mono-complete gvfs-bin libxss1 rxvt-unicode-256color x11-xserver-utils sudo vim libxkbfile1 libsecret-1-0

# update npm
RUN npm install npm -g

# install vscode
# RUN wget -O vscode-amd64.deb  https://go.microsoft.com/fwlink/?LinkID=760868
# RUN dpkg -i vscode-amd64.deb
# RUN rm vscode-amd64.deb

RUN echo 'Installing VsCode' && \ 
curl -o vscode.deb -J -L "$VSCODE" && \ 
dpkg -i vscode.deb && rm -f vscode.deb

# create our developer user
workdir /root
run groupadd -r developer -g 1000
run useradd -u 1000 -r -g developer -d /developer -s /bin/bash -c "Software Developer" developer
copy /developer /developer
workdir /developer

# enable sudo for developer
run echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer

# fix developer permissions
run chmod +x /developer/bin/*
run chown -R developer:developer /developer
user developer

# setup our ports
expose 5000
expose 3000
expose 3001

# set environment variables
env PATH /developer/.npm/bin:$PATH
env NODE_PATH /developer/.npm/lib/node_modules:$NODE_PATH
env SHELL /bin/bash

# mount points
volume ["/developer/.config/Code"]
volume ["/developer/.vscode"]
volume ["/developer/.ssh"]
volume ["/developer/project"]

# start vscode
entrypoint ["/developer/bin/start-vscode"]

