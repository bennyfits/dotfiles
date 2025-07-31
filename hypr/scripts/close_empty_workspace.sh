 #!/bin/bash
function handle {

  if [[ ${1:0:11} == "closewindow" ]]; then
    $(hyprctl activeworkspace -j | jq '.windows')
    $(hyprctl activeworkspace -j | jq '.id')
    if [ $(hyprctl activeworkspace -j | jq '.id') -gt 2 ] && [ $(hyprctl activeworkspace -j | jq '.windows') -eq 0 ]; then
      bash -c "hyprctl dispatch workspace 2"
    fi
  fi
}

socat -t7889400 - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done