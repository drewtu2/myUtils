#!/bin/bash

# Some colors for fancy prints
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# Sets up environment as follows
# - For dot-files that do not exist within the home directory, create a soft-link
# back to the ones stored in $MYUTILS_HOME/dot-files
# - Print out what files already existed (do not overwrite them)

printf "\n*****************************************\n"
printf "Beginning installation script..."
printf "\n*****************************************\n"

##############################################################################
# Determine what our startup file is we should be using....
##############################################################################
BASH_PROFILE=~/.bash_profile
BASH_ALIAS=~/.bash_aliases
BASH_RC=~/.bashrc

if [ -f $BASH_PROFILE ]; then
    STARTUP=$BASH_PROFILE
elif [ -f $BASH_ALIAS ]; then
    STARTUP=$BASH_ALIAS
elif [ -f $BASH_RC ]; then
    STARTUP=$BASH_RC
fi
printf "Startup file is: $STARTUP\n\n"

##############################################################################
# Add current path to startup file if necessary...
##############################################################################
if grep -Fq "MYUTILS_HOME" $STARTUP; then
    printf "MYUTILS already exists in $STARTUP...\n\n"
else
    printf "Adding MYUTILS_HOME shortcut... \n" 
    printf "export MYUTILS_HOME=`pwd`\n" >> $STARTUP
fi

#source $STARTUP > /dev/null
printf "Sourcing startup file... \n"
#source $STARTUP 
export MYUTILS_HOME=pwd # source the startup script wasn't having the changes take effect...
printf "MYUTILS_HOME: $MYUTILS_HOME \n"

##############################################################################
# Create soft links to all our dot files if they don't already exist.  
##############################################################################
shopt -s dotglob                                    # Enable globbing .dotfiles
for f in $MYUTILS_HOME/dot-files/*
do
    filename=$(basename "$f")
    #printf "$filename \n"

    if [ -f "~/$filename" ]; then
        printf "${RED}[ NOT OK ] \t$filename already exists in the home directory. Skipping...${NC}\n"
    elif [ -f "$f" ]; then                          # Make sure its a file
        printf "${GREEN}[   OK   ] \t$filename does not exist. Creating soft link...${NC}\n"
        ln -s $f ~/$filename
    fi 
done
shopt -u dotglob                                    # Disable globbing .dotfiles

touch ~/.l_bashrc

##############################################################################
# Add our bashrc to the startup sequence
##############################################################################
if grep -Fq "my_bashrc" $STARTUP; then
    printf "\nmy_bashrc already exists in $STARTUP...\n"
else
    printf "source ~/.my_bashrc\n" >> $STARTUP
    source $STARTUP > /dev/null
fi

printf "\n*****************************************\n"
printf "Finished running installation script...\n"
printf "*****************************************\n"
