#!/bin/bash

# Just update the OS related stuff.
sudo apt-get dist-upgrade
sudo apt-get update
sudo apt-get upgrade

# Get some useful packages
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install python3
sudo apt-get install python3-venv

# Install git and then clone the utils repo
# If this script is running, this has already been done...
#sudo apt-get install git
#git clone https://www.github.com/drewtu2/myUtils.git


