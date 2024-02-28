## Metavision SDK docker container
#
#

FROM registry.git.ee.ethz.ch/pbl/research/event-camera/docker/metavisionsdk-docker/metavisionsdk22:latest


ARG USERNAME
ARG USER_ID
ARG GROUP_ID
ARG PASSWORD

RUN groupadd -g ${GROUP_ID} ${USERNAME} && useradd -u ${USER_ID} -g ${GROUP_ID} -ms /bin/bash ${USERNAME} && usermod -aG sudo ${USERNAME} && echo "${USERNAME}:${PASSWORD}" | chpasswd

USER ${USERNAME}
WORKDIR /home/${USERNAME}