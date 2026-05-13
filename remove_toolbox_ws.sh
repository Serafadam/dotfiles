#!/usr/bin/env bash

while
  getopts ":w:" option;
do
  case $option in
    w)
      workspace_name="$OPTARG"
      ;;
    *)
      echo "Usage: $0  [-w workspace_name]"
      exit 1
      ;;
  esac
done

echo "Workspace name: $workspace_name"
while true
do
    read -r -p 'Do you want to continue? ' choice
    case "$choice" in
      n|N) break;;
      y|Y) podman stop  $workspace_name && toolbox rm $workspace_name && rm -rf $HOME/ws/$workspace_name && break;;
      *) echo 'Response not valid';;
    esac
done
