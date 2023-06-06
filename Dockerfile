## Metavision SDK docker container
#
#

#FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04



FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ARG username
ARG password
ARG user_id

ENV DEBIAN_FRONTEND "noninteractive"
ENV TZ "Europe/Berlin"
ENV DUMMY=""
ENV CMAKE_PREFIX_PATH=/usr/local/lib/python3.8/dist-packages/torch/share/cmake/ 
ENV CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda

ADD metavision.list /etc/apt/sources.list.d

RUN apt update -y && apt upgrade -y && apt install -y ca-certificates git vim curl wget cmake autoconf rsync automake libcanberra-gtk-module mesa-utils ffmpeg python3-pip python3-tk python3.9-dev sudo libboost-program-options-dev libeigen3-dev build-essential parallel 

RUN python3 -m pip install "opencv-python>=4.5.5.64" "sk-video==1.1.10" "fire==0.4.0" "numpy>=1.23.4" pandas scipy h5py torch tensorflow jupyter jupyterlab matplotlib "ipywidgets==7.6.5" numba llvmlite profilehooks "pytorch_lightning==1.8.6" "pycocotools==2.0.4" "tqdm==4.63.0" "torchmetrics==0.7.2" "seaborn==0.11.2" "kornia==0.6.8" "pillow==9.3.0"

#RUN apt install -y libogre-1.12-dev libimgui-dev libfreetype-dev


RUN apt -y install metavision-sdk




RUN useradd -u $user_id -ms /bin/bash $username && usermod -aG sudo $username && echo "$username:$password" | chpasswd

USER $username
WORKDIR /home/$username
