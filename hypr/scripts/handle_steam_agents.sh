#!/bin/bash
declare windows=$(hyprctl clients -j)

function window_attr () {
  echo $(jq --raw-output ".[] | select(.address==$(echo "$address")) | .$1" <<< $windows)
}

function handle () {
  windows=$(hyprctl clients -j)

  if [[ ${1:0:10} == "openwindow" ]]; then
    address="\"0x${1:12:12}\""
    if [[ $(window_attr class) = steam_app_* ]] && [[ "$(window_attr size[1])" -lt 50 ]]; then
      bash -c "hyprctl dispatch movetoworkspacesilent 'special:steam_agents', address:$address"
    fi
  fi
}

socat -t7889400 - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done