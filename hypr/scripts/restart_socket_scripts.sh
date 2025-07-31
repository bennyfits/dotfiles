#!/bin/bash
declare local_path=$(dirname "$(realpath $0)")
declare scripts=(
  autoload_g600_mapping.sh
  close_empty_workspaces.sh 
)

for script in $scripts; do
  for pid in $(ps -ef | grep $script | awk '{print $2}'); do kill -9 $pid; done
  bash -c "hyprctl dispatch exec $local_path/$script"
done