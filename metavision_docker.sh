#!/bin/bash

xhost '+local:*'

if [[ $(lshw -C display | grep vendor) =~ Nvidia ]]; then
  docker run -it --rm --privileged --gpus all -v /dev/bus/usb:/dev/bus/usb -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v $(pwd):/home/`whoami`/pwd -e GDK_SCALE=0.5  registry.git.ee.ethz.ch/pbl/research/armasuisse/armasuisse-2023/metavisionsdk_docker/metavision22:latest  /bin/bash -c "metavision_studio; while /usr/bin/pgrep metavision >/dev/null; do sleep 1; done"
else
  docker run -it --rm --privileged  -v /dev/bus/usb:/dev/bus/usb -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v $(pwd):/home/`whoami`/pwd -e GDK_SCALE=0.5  registry.git.ee.ethz.ch/pbl/research/armasuisse/armasuisse-2023/metavisionsdk_docker/metavision22:latest  /bin/bash -c "metavision_studio; while /usr/bin/pgrep metavision >/dev/null; do sleep 1; done"
fi
