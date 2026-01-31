FROM ros:humble-ros-base

ARG USER=frostlab
ARG DEBIAN_FRONTEND=noninteractive
USER root

# Set up a new user
RUN useradd -ms /bin/bash ${USER} \
    && usermod -aG sudo ${USER} \
    && usermod -aG dialout ${USER} \
    && echo "${USER}:${USER}" | chpasswd \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

