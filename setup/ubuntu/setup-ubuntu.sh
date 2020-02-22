#!/bin/bash
# Inspired by: https://github.com/snwh/ubuntu-post-install

# Trigger sudo so we have it. 
# sudo -v

# Just update the OS related stuff.
#sudo apt-get -qq update
#sudo apt-get -qq upgrade

install_from_list "installing ubuntu packages" "ubuntu_install"

pip install --upgrade pip
pip3 install --upgrade pip

# Autohide the launcher
# https://askubuntu.com/questions/274153/command-line-for-hiding-and-unhiding-unity-panel
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
# Un-Autohide the launcher
# gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 0

