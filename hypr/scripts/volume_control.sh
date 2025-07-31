#!/bin/bash
if [[ $(jq --raw-output '.[] | .class' <<< $(hyprctl clients -j)) = *"org.pulseaudio.pavucontrol"* ]]; then
  bash -c "killall pavucontrol >> /dev/null"
else
  bash -c "pavucontrol >> /dev/null"
fi