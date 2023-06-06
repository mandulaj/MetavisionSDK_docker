#!/bin/bash

xhost '+local:*'


docker run -t -i --privileged --gpus all -v /dev/bus/usb:/dev/bus/usb -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v $(pwd):/home/`whoami`/pwd -e GDK_SCALE=0.5  metavision bash
