#!/bin/bash

# Takes a selection from the user and copies it to the clipboard.
# The user can then paste it where they want. 
# Requires scrot and xclip to be installed.
# Both are available through apt.
#
# Note that the sleep is required for this to work with the keybindings. 
# https://stackoverflow.com/questions/35500163/bash-script-with-scrot-area-not-working

sleep 0.2; scrot -e 'xclip -selection clipboard -t image/png -i $f' -s
