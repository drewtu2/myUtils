#!/bin/bash

# Just update the OS related stuff.
sudo apt-get -qq dist-upgrade
sudo apt-get -qq update
sudo apt-get -qq upgrade

# Get some useful packages
sudo apt-get install -qq vim
sudo apt-get install -qq tmux

# Install and update python
sudo apt-get install -qq python3
sudo apt-get install -qq python3-venv
sudo apt-get install -qq python3-tk
pip install --upgrade pip
pip3 install --upgrade pip

# Install git and then clone the utils repo
# If this script is running, this has already been done...
#sudo apt-get install git
#git clone https://www.github.com/drewtu2/myUtils.git

# Autohide the launcher
# https://askubuntu.com/questions/274153/command-line-for-hiding-and-unhiding-unity-panel
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
# Un-Autohide the launcher
# gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 0
# Usefull for gnome-open
# gnome-open will open files with the appropriate software
sudo apt-get install -qq libgnome2-bin
