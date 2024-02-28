Docker environment for the Metavision SDK Ubuntu 22.04
======================================================

Includes the full [Metavision SDK](https://docs.prophesee.ai/stable/installation/linux.html#chapter-installation-linux) including the `metavision_studio` app


![Metavision Studio](https://docs.prophesee.ai/stable/_images/metavision_studio_hand_spinner.png)

## Build User image

1. Make sure to have the following variables exported (eg. by placing them in your `.bashrc`):
```
# This is your host user ID and group ID. The derived docker image user will be created with same ID in order to have same Read/Write permissions
export USER_ID=`id -u`   
export GROUP_ID=`id -g`
```

2. Log into the PBL Docker Registry: 
```bash
docker login registry.git.ee.ethz.ch
```

3. Clone this repo:
```bash
git clone git@git.ee.ethz.ch:pbl/research/event-camera/docker/MetavisionSDK-docker.git
cd MetavisionSDK-docker
```

4. Build Docker User Image:
```bash
docker compose build metavisionsdk
```

## Usage
```bash
# Run metavision_studio
docker run -it --privileged -e DISPLAY -v /dev/bus/usb:/deb/bus/usb -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /home/${USER}/.Xauthority:/home/${USER}/.Xauthority -v $(pwd):/home/${USER}/pwd --rm --ipc=host --net=host metavisionsdk22_${USER}:latest /bin/bash -c "metavision_studio; while /usr/bin/pgrep metavision >/dev/null; do sleep 1; done"
# Run a Bash in the container
docker run -it --privileged -e DISPLAY -v /dev/bus/usb:/deb/bus/usb -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /home/${USER}/.Xauthority:/home/${USER}/.Xauthority -v $(pwd):/home/${USER}/pwd --rm --ipc=host --net=host metavisionsdk22_${USER}:latest bash
```



## Build base image from scratch
Alternatively, you can build the base image from scratch. However for this, you have to collect your own `metavision22.list` from the Prophesee website.  Sign up at [https://www.prophesee.ai/metavision-intelligence-sdk-download/](https://www.prophesee.ai/metavision-intelligence-sdk-download/) and save the `metavision.list` to the root of the repository directory.

```bash
# Steps 1-3 are the same as above
docker login registry.git.ee.ethz.ch
git clone git@git.ee.ethz.ch:pbl/research/event-camera/docker/MetavisionSDK-docker.git
cd MetavisionSDK-docker

# Copy you rmetavison.list to the root of the 
cp ~/Downloads/metavision.list metavision22.list

# Build the base docker container
docker compose build base

# Build the User Image:
docker compose build metavisionsdk
```