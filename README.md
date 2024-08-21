Docker environment for the Metavision SDK Ubuntu 22.04
======================================================

Includes the full [Metavision SDK](https://docs.prophesee.ai/stable/installation/linux.html#chapter-installation-linux) including the `metavision_studio` app


![Metavision Studio](https://docs.prophesee.ai/stable/_images/metavision_studio_hand_spinner.png)

## Add user to the docker group
You can check if your user is in the docker group with
```bash
grep /etc/group -e "docker"
```
If your output looks something like this:
```bash
docker:x:999:
```
where your username is not mentioned, then you need to add your user to the docker group.
(Also, if you can only call docker commands with sudo, you probably need to add yourself to the docker group.)

To add your user to the docker group type the following in a terminal:

```bash
sudo usermod -aG docker <your_username>
```

To make this changes effective you have to log in and out of your account and in some cases you might even have to reboot your computer.

## Build User image

1. Make sure to have the following variables exported (eg. by placing them in your `.zshrc` or `.bashrc`):
```
# This is your host user ID and group ID. The derived docker image user will be created with same ID in order to have same Read/Write permissions
export USER_ID=`id -u`   
export GROUP_ID=`id -g`
```

2. Log into the PBL Docker Registry: 
```bash
docker login registry.git.ee.ethz.ch
```
Use your GitLab credentials. If you set up 2FA, you will have to create a [Personal Access Token](https://git.ee.ethz.ch/-/user_settings/personal_access_tokens).

3. Clone this repo:
```bash
git clone git@git.ee.ethz.ch:pbl/research/event-camera/docker/MetavisionSDK-docker.git
cd MetavisionSDK-docker
```

4. Build Docker User Image:
```bash
./build_user.sh
```

This pulls the base image from the registry and builds a derived image with a user that has the same `$USERNAME`, `$USER_ID` and `$GROUP_ID` as the host user.

You can also do this using:

```bash
docker compose build metavisionsdk
```




## Usage

Strat Metavision Studio with:
```bash
./metavision_studio.sh
```

This also creates the required config files and sets all permisions.

You can also launch it directly using docker compose:
```bash
docker compose run metavisionsdk
```

Or run it explicitly using `docker run`. Note that in order to get GUI, you have to run in `--privileged` mode, share the X11 authority files, export the `$DISPLAY` variable and allow sufficient shared memory with `--shm-size '2gb'`.


```bash
# Run metavision_studio
docker run -it --privileged -e DISPLAY -v /dev/bus/usb:/deb/bus/usb -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /home/${USER}/.Xauthority:/home/${USER}/.Xauthority -v $(pwd):/home/${USER}/pwd --rm --ipc=host  --shm-size 2gb --net=host metavisionsdk22_${USER}:latest /bin/bash -c "metavision_studio; while /usr/bin/pgrep metavision >/dev/null; do sleep 1; done"
# Run a Bash in the container
docker run -it --privileged -e DISPLAY -v /dev/bus/usb:/deb/bus/usb -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /home/${USER}/.Xauthority:/home/${USER}/.Xauthority -v $(pwd):/home/${USER}/pwd --rm --ipc=host --net=host metavisionsdk22_${USER}:latest bash
```

### Using USB cameras

In oder to use the USB cameras, the `/dev/bus/usb` has to be mounted and the camera device file has to have RW permissions for all users. Inside of the container, this can be done using the helper script
```bash
/scripts/chmod.sh # Finds all EVK4 cameras and changes permissions to 666. Will prompt for sudo password ("password")
```

You may have to start the container after connecting the USB cameras.


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
