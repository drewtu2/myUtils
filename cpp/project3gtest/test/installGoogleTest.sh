#!/bin/bash

shopt -s dotglob
if [ ! -d "../.googletest" ]; then
    cd ..
    git clone https://github.com/google/googletest.git .googletest
    cd test
fi
shopt -u dotglob
