#!/bin/bash
function workspace_attr () {
  echo $(jq --raw-output .$1 <<< $(hyprctl activeworkspace -j))
}

function open_workspaces () {
  echo $(jq --raw-output '.[] | .id' <<< $(hyprctl workspaces -j))
}