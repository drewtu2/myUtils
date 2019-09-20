#!/bin/bash

# The installation script for a fresh Mac...

# Install Brew and Brew Cask
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions

## Brew Installs
brew install git
brew install tmux
brew install wget
brew install macvim
brew install python3

# Install GNU core utilities (those that come with macOS are outdated)
brew 'coreutils'

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
#brew 'findutils'


# Apps
brew cask install dropbox
brew cask install google-chrome
brew cask install alfred2
#brew cask install 'atom'
#brew cask install 'docker'
#brew cask install 'github'
#brew cask install 'slack'
#brew cask install 'spotify'
#brew cask install 'sublime-text'
#brew cask install 'iTerm'
