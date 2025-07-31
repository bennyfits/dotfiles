#!/bin/bash
declare local_path=$(dirname "$(realpath $0)")
source "$local_path/lib/windows.sh"
source "$local_path/lib/workspaces.sh"
source "$local_path/lib/monitors.sh"

title=$(active_window_attr title)
title="${title%\"}"
title="${title#\"}"

notify-send "$title.json"
if [ ! -e "$HOME/.config/input-remapper-2/presets/Logitech Gaming Mouse G600/$title.json" ]; then
  cd ~/.config/input-remapper-2/presets/Logitech\ Gaming\ Mouse\ G600
  echo $(pwd)
  cp Default.json "$title.json"
  notify-send "New mapping: $title"
fi