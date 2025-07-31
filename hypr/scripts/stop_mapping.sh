#!/bin/bash
notify-send "Disabling all mappings."
export G600_MAPPING=""
export G600_WINDOW=""
sudo input-remapper-control --command stop --device "Logitech Gaming Mouse G600"
