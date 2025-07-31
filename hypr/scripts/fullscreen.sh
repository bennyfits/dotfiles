#!/bin/bash
config_path=$(dirname "$(realpath $0)")/slides/config
active_address=$(jq '.address' <<< $(hyprctl activewindow -j))

function maximize_window {
  for slide in $config_path/*; do
    address=$(hyprctl clients -j | jq ".[] | $(jq --raw-output .selector $slide) | .address")
    if [ "$address" = "$active_address" ]; then
      return
    fi
  done

  bash -c "hyprctl dispatch fullscreen 0"
}

maximize_window