#!/bin/sh

# Sets up environment as follows
# - For dot-files that do not exist within the home directory, create a soft-link
# back to the ones stored in $MYUTILS_HOME/dot-files
# - Print out what files already existed (do not overwrite them)


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
echo "Startup file is: $STARTUP"

##############################################################################
# Add current path to startup file if necessary...
##############################################################################
if grep -Fxq "MYUTILS_HOME" $STARTUP; then
    echo "MYUTILS already exists in $STARTUP... "
else
    echo "export MYUTILS_HOME=`pwd`" >> $STARTUP
fi

source $STARTUP 

##############################################################################
# Create soft links to all our dot files if they don't already exist.  
##############################################################################
shopt -s dotglob                                    # Enable globbing .dotfiles
for f in $MYUTILS_HOME/dot-files/*
do
    filename=$(basename "$f")

    if [ -f ~/$filename ]; then
        echo "$filename already exists in the home directory. Skipping..."
    else
        echo "Creating soft link for $filename..."
        ln -s $f ~/$filename
    fi 
done
shopt -u dotglob                                    # Disable globbing .dotfiles

##############################################################################
# Add our bashrc to the startup sequence
##############################################################################
if grep -Fxq "my_bashrc" $STARTUP; then
    echo "my_bashrc already exists in $STARTUP... "
else
    echo "source ~/.my_bashrc" >> $STARTUP
    source $STARTUP 
fi
