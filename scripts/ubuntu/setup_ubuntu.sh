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
sudo apt-get install python3-tk

# Install git and then clone the utils repo
# If this script is running, this has already been done...
#sudo apt-get install git
#git clone https://www.github.com/drewtu2/myUtils.git

# Autohide the launcher
# https://askubuntu.com/questions/274153/command-line-for-hiding-and-unhiding-unity-panel
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
# Un-Autohide the launcher
# gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 0
