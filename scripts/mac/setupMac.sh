#!/bin/bash

# The installation script for a fresh Mac...

# Install Brew and Brew Cask
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions

# Brew Installs
brew install git
brew install tmux

brew cask install dropbox
brew cask install google-chrome
brew cask install alfred2


