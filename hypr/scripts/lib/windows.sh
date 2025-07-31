#!/bin/bash
function config_val () {
  echo $(jq --raw-output .$1 <<< $json)
}

function get_window_address () {
  echo "\"$(jq --raw-output ".[] | ${1} | .address" <<< $windows)\""
}

function active_window_attr() {
  echo $(jq .$1 <<< $(hyprctl activewindow -j))
}

function window_attr () {
  echo $(jq --raw-output ".[] | select(.address==$(echo "$address")) | .$1" <<< $windows)
}

function get_window_json() {
  echo $(jq --raw-output ".[] | select(.address==$(echo "$address"))" <<< $windows)
}
