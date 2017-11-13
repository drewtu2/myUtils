#!/bin/bash

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
    printf "export MYUTILS_HOME=`pwd`\n" >> $STARTUP
fi

source $STARTUP > /dev/null

##############################################################################
# Create soft links to all our dot files if they don't already exist.  
##############################################################################
shopt -s dotglob                                    # Enable globbing .dotfiles
for f in $MYUTILS_HOME/dot-files/*
do
    filename=$(basename "$f")

    if [ -f ~/$filename ]; then
        printf "$filename already exists in the home directory. Skipping...\n"
    elif [ -f $f ]; then                          # Make sure its a file
        printf "Creating soft link for $filename...\n"
        ln -s $f ~/$filename
    fi 
done
shopt -u dotglob                                    # Disable globbing .dotfiles

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
