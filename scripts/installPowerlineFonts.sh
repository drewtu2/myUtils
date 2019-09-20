#!/bin/bash

# Installs the powerline fonts to get pretty displays when using the airline for
# vim. Probably requires the terminal to be restart for changes to take effect. 

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

