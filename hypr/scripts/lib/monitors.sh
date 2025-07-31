#!/bin/bash
declare monitors=$(hyprctl monitors -j)
active_x=$(hyprctl monitors -j | jq ".[] | select(.id==$(hyprctl activeworkspace -j | jq '.monitorID')) | .x")
active_y=$(hyprctl monitors -j | jq ".[] | select(.id==$(hyprctl activeworkspace -j | jq '.monitorID')) | .y")
active_width=$(hyprctl monitors -j | jq ".[] | select(.id==$(hyprctl activeworkspace -j | jq '.monitorID')) | .width")
active_height=$(hyprctl monitors -j | jq ".[] | select(.id==$(hyprctl activeworkspace -j | jq '.monitorID')) | .height")

function get_workspace_home_position() {
  x=0
  y=0
}

function monitor_attr () {
  echo $(jq --raw-output ".[] | select(.id==0) | .$1" <<< $monitors )
}

function get_monitor_home_position() {
  x=$(monitor_attr x)
  y=$(monitor_attr y)
  
  echo $x, $y
}