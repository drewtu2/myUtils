#!/bin/bash
# Colored printing example
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "I ${RED}love${NC} Stack Overflow"
printf "I ${RED}love${NC} Stack Overflow\n"


