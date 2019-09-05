#!/bin/bash

set -e
#exit if error happens

. $(dirname $0)/support.inc
#excute support.inc 

if [ -z "$1" ]; then    
    echo "usage: $(basename $0) <SDCARD_PARTITION_1>"
    exit 1
elif [ ! -b "$1" ]; then
    echo "E: Invalid SDCARD_PARTITION_1: $1"
    exit 1
fi
SDCARD_PARTITION_1=$1

#KERNEL_IMAGE_FOR_UNLEASHED: this variable is from support.inc, bootable kernel image
#Does the file exist?
if [ ! -f "$KERNEL_IMAGE_FOR_UNLEASHED" ]; then
    echo "E: Invalid KERNEL_IMAGE_FOR_UNLEASHED (no such file): $KERNEL_IMAGE_FOR_UNLEASHED"
    echo 
    echo "I: Did you forgot to run 'debian-mk-kernel.mk' script?"
    exit 2
fi

#call confirm function in support.inc
#to confirm install kernel to sdcard
if ! confirm "Really install kernel to device $SDCARD_PARTITION_1"; then
    exit 0
fi

#echo message on screen
echo "I: Copying kernel image, please wait..."
sudo dd "if=$KERNEL_IMAGE_FOR_UNLEASHED" "of=${SDCARD_PARTITION_1}" bs=4096
echo "I: Done"

