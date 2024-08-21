#!/bin/bash

xhost '+local:*'

if `lspci -v  | grep -iq nvidia`; then
  GPU_FLAG='--gpus all'
else
  GPU_FLAG=
fi

#create config dir if it does not exist
mkdir -p /home/$USER/.config/Metavision\ Studio

docker run -it --rm --privileged $GPU_FLAG -v /dev/bus/usb:/dev/bus/usb -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v $(pwd):/home/`whoami`/pwd -v /home/$USER/.config/Metavision\ Studio:/home/$USER/.config/Metavision\ Studio -e GDK_SCALE=0.5  --shm-size 1000000000 metavisionsdk22_${USER}:latest  /bin/bash -c "/scripts/chmod.sh && metavision_studio; while /usr/bin/pgrep metavision >/dev/null; do sleep 1; done"
