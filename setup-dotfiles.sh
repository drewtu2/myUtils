#!/bin/bash

# This script installs myUtils into a new system
# Should be run from the home directory of myUtils

source setup/functions/import_functions
import_functions "setup/functions"
ensure_directory "myUtils"
print_header "Installing myUtils"

# Sets up environment as follows
# - For dot-files that do not exist within the home directory, create a soft-link
# back to the ones stored in $MYUTILS_HOME/dot-files
# - Print out what files already existed (do not overwrite them)

##############################################################################
# Determine what our startup file is we should be using....
##############################################################################
BASH_PROFILE=${HOME}/.bash_profile
BASH_ALIAS=${HOME}/.bash_aliases
BASH_RC=${HOME}/.bashrc

if [ -f $BASH_PROFILE ]; then
    STARTUP=$BASH_PROFILE           # Only loaded on login shell
elif [ -f $BASH_ALIAS ]; then
    STARTUP=$BASH_ALIAS             # ???
elif [ -f $BASH_RC ]; then
    STARTUP=$BASH_RC                # Loads at every new shell
fi

printf "Startup file is: $STARTUP\n"

##############################################################################
# Add current path to startup file if necessary...
##############################################################################
if grep -Fq "MYUTILS_HOME" $STARTUP; then
    printf "MYUTILS already exists in $STARTUP...\n"
else
    printf "Adding MYUTILS_HOME shortcut... \n" 
    printf "export MYUTILS_HOME=`pwd`\n" >> $STARTUP
fi

export MYUTILS_HOME=$(pwd) # source the startup script wasn't having the changes take effect...
printf "MYUTILS_HOME: $MYUTILS_HOME \n"

##############################################################################
# Create soft links to all our dot files if they don't already exist.  
##############################################################################
for f in $(find $MYUTILS_HOME/dot-files/ -type f -name ".**" ! -name "*.swp")
do
    filename=$(basename "$f")

    # Does the file already exist?
    if [ -e "${HOME}/$filename" ]; then             
        print_color "[  FAIL  ] \t$filename already exists in the home directory. Skipping...\n" ${RED}
    # File doesn't exist... make sure we're linking to a file
    elif [ -f "$f" ]; then
        print_color "[ SUCCESS] \t$filename does not exist. Creating soft link...\n" ${GREEN}
        ln -s $f ${HOME}/$filename
    fi 
done

touch ${HOME}/.l_bashrc                                   # Make .l_bashrc exist

##############################################################################
# Add our bashrc to the startup sequence
##############################################################################
if grep -Fq "my_bashrc" $STARTUP; then
    printf "\nmy_bashrc already exists in $STARTUP...\n"
else
    printf "source ${HOME}/.my_bashrc\n" >> $STARTUP
    source $STARTUP > /dev/null
fi

# idk where to put these. 
./setup/installVundle.sh
./setup/installPowerlineFonts.sh
vim +PluginInstall +qall

print_header "Finished running installation script..."
