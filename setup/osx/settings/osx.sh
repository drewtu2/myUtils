#!/usr/bin/env bash

echo "Applying OSX settings ..."
# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront (seems not to be required)
sudo -v

# Keep-alive: update existing `sudo` time stamp until everything is applied
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name
COMPUTERNAME="Kevins"
HOSTNAME='mbp'
LOCALHOSTNAME='mbp'

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $COMPUTERNAME
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $LOCALHOSTNAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $LOCALHOSTNAME

###############################################################################
# General tuning                                                              #
###############################################################################

# Show the ~/Library folder
chflags nohidden ~/Library

# Store screenshots directly on desktop
defaults write com.apple.screencapture location ~/Desktop
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Get rid of the unused dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock dashboard-in-overlay -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
#defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Doesn't work with High Sierra any longer...
# Disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# make sure everything uses these new settings                                #
###############################################################################

killall Finder
killall Dock
# killall SystemUIServer
