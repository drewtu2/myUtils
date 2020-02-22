#!/usr/bin/env bash

# The installation script for a fresh Mac...

# -------------------------------------------------------------------------------------------

# Install all software not bundled in Homebrew
if ask_question 'Do you want to install un-brewed software?'; then
    echo "Installing un-brewed software ..."
    for i in ./installer/*; do
        echo "Executing $i ..."
        sh $i
    done
fi

# -------------------------------------------------------------------------------------------

# Install all homebrew supported software
if ask_question 'Do you want to install homebrew software?'; then
    echo "Installing homebrew software ..."
    brew bundle
fi

# -------------------------------------------------------------------------------------------

# Install application settings
if ask_question 'Do you want to install application and MacOS settings?'; then
    echo "Installing application settings ..."
    for s in ./settings/*; do
        echo "Apply settings from $s ..."
        sh $s
    done
fi

# -------------------------------------------------------------------------------------------
