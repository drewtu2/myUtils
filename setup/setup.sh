#!/bin/bash


# Get access to all the helper functions 
source functions/import_functions
import_functions "functions"

# Depending on what type of machine we're seting up...
if [ $(uname)  = "Darwin" ]; then
    ./osx/setup-mac.sh
elif [ $(uname) = "Linux" ]; then
    ./ubuntu/setup-ubuntu.sh
fi

# Last action: activate dotfiles from repo 
MAIN_DIR=$(dirname $(dirname "%0")) # Should give myUtils directory
#if ask_question 'Do you want to install new .dotfiles?'; then
#    echo "Installing new .dotfiles ..."
#	cd $MAIN_DIR && ./setup-dotfiles.sh
#fi
echo "Installing new .dotfiles ..."
cd $MAIN_DIR && ./setup-dotfiles.sh
unset MAIN_DIR
