#!/bin/bash

CAMERAS=$(lsusb -d 04b4: |  awk '{print "/dev/bus/usb/"$2"/"$4}' |   sed 's/://' | tr '\n' ' ')


if [ -n "$CAMERAS" ]; then
    for cam in $CAMERAS; do
        current_perms=$(stat -c "%a" "$cam")       
	
        if [ "$current_perms" != "666" ]; then
            echo "Changing permission of $cam to 666"                                                                                       
	    sudo chmod 666 $cam
        else
            echo "$cam has correct permissions"
	fi   
    done
else
    echo "No Cameras detected"
fi
