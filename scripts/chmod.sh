#!/bin/bash

CAMERAS=$(lsusb -d 04b4: |  awk '{print "/dev/bus/usb/"$2"/"$4}' |   sed 's/://' | tr '\n' ' ')

if [ -n "$CAMERAS" ]; then
	sudo chmod 666 $CAMERAS
else
	echo "No Cameras detected"
fi
