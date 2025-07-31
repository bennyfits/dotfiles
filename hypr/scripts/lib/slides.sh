#!/bin/bash
function animate_from () {
  echo $(compute_position "from")
}

function animate_to () {
  echo $(compute_position to)
}

function compute_position () {
  config_x=$(config_val "$1[0]")
  config_y=$(config_val "$1[1]")
  monitor_x=$(monitor_attr x) 
  monitor_y=$(monitor_attr y)
  echo $(($config_x + $monitor_x)) $(($config_y + $monitor_y))
}