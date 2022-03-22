#!/bin/bash

# Installs the powerline fonts to get pretty displays when using the airline for
# vim. Probably requires the terminal to be restart for changes to take effect. 

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

# More or less need to do this but hardcoding this because :shrug:.
# https://webinstall.dev/nerdfont/
# curl -sS https://webinstall.dev/nerdfont | bash

wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
mv "Droid Sans Mono 20 Nerd Font Complete.otf" ~/.local/share/fonts/

cd ..
rm -rf fonts



