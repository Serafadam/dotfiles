#!/ usr / bin / env bash

while
  getopts ":r:w:" option;
do
  case $option in
    r)
      ros_distro="$OPTARG"
      ;;
    w)
      workspace_name="$OPTARG"
      ;;
    *)
      echo "Usage: $0 [-r ros_distro] [-w workspace_name]"
      exit 1
      ;;
  esac
done

echo "ROS distro: $ros_distro"
echo "Workspace name: $workspace_name"


while true
do
    read -r -p 'Do you want to continue? ' choice
    case "$choice" in
      n|N) break;;
      y|Y) podman build . -t $workspace_name --build-arg=ROS_DISTRO=$ros_distro --build-arg=DOCKER_USER=$USER && mkdir $HOME/ws/$workspace_name && toolbox create --image localhost/$workspace_name && break;;
      *) echo 'Response not valid';;
    esac
done
