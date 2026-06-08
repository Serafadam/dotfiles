#!/usr/bin/env bash

# Initialize variables
ros=false
ros_distro=""
workspace_name=""
container_name="ubuntu:26.04"

# Parse command line options
while getopts ":rc:d:w:" option; do
  case $option in
    r)
      ros=true
      ;;
    c)
      container_name="$OPTARG"
      ;;
    d)
      ros_distro="$OPTARG"
      ;;
    w)
      workspace_name="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "Usage: $0 [-r] [-c container_name] [-d ros_distro] [-w workspace_name]"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      echo "Usage: $0 [-r] [-c container_name] [-d ros_distro] [-w workspace_name]"
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

# Display configuration
echo "ROS container: $ros"
if [ "$ros" = true ]; then
    echo "ROS distro: $ros_distro"
else
    echo "Container name: $container_name"
fi
echo "Workspace name: $workspace_name"

# Confirmation prompt
while true; do
    read -r -p 'Do you want to continue? [y/N] ' choice
    case "$choice" in
      [nN]|'')
        echo "Aborted."
        exit 0
        ;;
      [yY])
        if [ "$ros" = true ]; then
          podman build --no-cache -f ROSContainerfile -t "$workspace_name" \
            --build-arg=ROS_DISTRO="$ros_distro" \
            --build-arg=DOCKER_USER="$USER" && \
          mkdir -p "$HOME/ws/$workspace_name" && \
          toolbox create --image "localhost/$workspace_name" && break
        else
          podman build --no-cache -f Containerfile -t "$workspace_name" \
            --build-arg=DOCKER_USER="$USER" && \
            --build-arg=IMAGE="$container_name"
          mkdir -p "$HOME/ws/$workspace_name" && \
          toolbox create --image "localhost/$workspace_name" && break
        fi
        ;;
      *)
        echo 'Response not valid. Please answer y or n.' >&2
        ;;
    esac
done
