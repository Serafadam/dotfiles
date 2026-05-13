ARG ROS_DISTRO=jazzy
FROM docker.io/library/ros:${ROS_DISTRO}-ros-base
ARG DOCKER_USER=test_user
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /ws
COPY ./install.sh /ws/install.sh 

RUN sh /ws/install.sh
COPY ./nvm_install.sh /ws/nvm_install.sh
RUN echo ${DOCKER_USER}
RUN usermod -l ${DOCKER_USER} ubuntu

RUN sh /ws/nvm_install.sh
