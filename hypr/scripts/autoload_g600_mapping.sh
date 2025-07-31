#!/usr/bin/env bash
declare local_path=$(dirname "$(realpath $0)")
source "$local_path/lib/windows.sh"
source "$local_path/lib/workspaces.sh"
source "$local_path/lib/monitors.sh"

export G600_MAPPING="Default"
export G600_WINDOW="G600 Default"

declare windows

function handle {

  windows=$(hyprctl clients -j)
  
  open_windows=$(jq --raw-output '.[]' <<< $windows)

  # Handle close window events when using a non-default mapping.
  if [[ ${1:0:11} =  "closewindow" ]]; then 
  
    # Do nothing if the default profile is G600 Default
    if [[ "$G600_MAPPING" = "Default" ]]; then return; fi

    address=$(get_window_address  "select(.title==\"$(echo $G600_WINDOW )\")")

    # Load the default profile if the tracked window is not in the list of all windows
    if [[ $address = "\"\"" ]]; then
      pkill -f Ubisoft
      notify-send "Loading default G600 profile."
      export G600_MAPPING="Default"
      export G600_WINDOW="G600 Default"
      sudo input-remapper-control --command start --device "Logitech Gaming Mouse G600" --preset "Default"
    fi

  fi

  # Handle active window events.
  if [[ ${1:0:13} = "activewindow>" ]]; then
    address=$(active_window_attr aaddress)
    # Set up the profile name: this_is_a_profile_name
    title=$(active_window_attr title)
    initial_title=$(active_window_attr initialTitle)
    class=$(active_window_attr class)

    # Ignore windows not on the Games worksapce.
    if [ $(workspace_attr id) -lt 100 ]; then return; fi

    # Format the string to match our mapping file names
    window=${title:=$initial_title}
    window="${window%\"}"
    window="${window#\"}"
    window=$(xargs -0 <<< $window)

    # Ignore windows with blank titles.
    if [[ "$window" = "" ]]; then return; fi

    # Ignore Steam property windows.
    if [[ "$class" = "\"steam\"" ]]; then return; fi

    # Verify that a profile exists before changing.
    if [ -e "$HOME/.config/input-remapper-2/presets/Logitech Gaming Mouse G600/$window.json" ]; then

      # Verify the profile is not currently the active profile and assign it if it isn't.
      if [[ "$G600_MAPPING" != "$window" ]]; then
        notify-send "Loading G600 profile for $window"
        export G600_MAPPING=$window
        export G600_WINDOW=$(echo $title | tr -d '"')
        sudo input-remapper-control --command start --device "Logitech Gaming Mouse G600" --preset "$window"
      fi

    fi

  fi

}

sudo input-remapper-control --command start --device "Logitech Gaming Mouse G600" --preset "Default"
socat -t7889400 - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done