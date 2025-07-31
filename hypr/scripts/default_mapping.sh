#!/bin/bash

export G600_MAPPING="Default"
export G600_WINDOW="G600 Default"

# Kill the existing profile autoloader
for pid in $(ps -ef | grep autoload_g600_mapping.sh | awk '{print $2}'); do kill -9 $pid; done

# Set the current mapping ot default.
notify-send "Loading default G600 profile."
sudo input-remapper-control --command start --device "Logitech Gaming Mouse G600" --preset "Default"

# Restart the profile autoloader
bash -c "hyprctl dispatch exec ~/.config/hypr/scripts/autoload_g600_mapping.sh"
