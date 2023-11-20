## Metavision SDK docker container
#
#

FROM registry.git.ee.ethz.ch/pbl/research/armasuisse/armasuisse-2023/metavisionsdk_docker/metavision22:latest

ARG username
ARG password
ARG user_id


RUN useradd -u $user_id -ms /bin/bash $username && usermod -aG sudo $username && echo "$username:$password" | chpasswd

USER $username
WORKDIR /home/$username