#!/bin/bash 

DRIVE_TO_WIPE=$1
echo $DRIVE_TO_WIPE

for n in `seq 7`; do dd if=/dev/urandom of=$DRIVE_TO_WIPE bs=8b conv=notrunc status=progress; done

