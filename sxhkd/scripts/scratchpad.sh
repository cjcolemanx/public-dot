#!/bin/bash

# Essentially checks for /tmp/scpad and displays a terminal if it exists 
#   or hides the same terminal if it doesn't exist.
# Calling this script will either create or delete the file, based on its
#   existance before the call.

# ID the scratchpad
winclass="$(xdotool search --class 'scpad')";

# If terminal doesn't exist...
if [ -z "$winclass" ]; then
  kitty --class scpad --name 'Scratchpad'
else
  # If scratchpad doesn't exist, create it and hide terminal
  if [ ! -f /tmp/scpad ]; then
    touch /tmp/scpad && xdo hide "$winclass"
  # If scratchpad does exist, remove it and show terminal
  elif [ -f /tmp/scpad ]; then
    rm /tmp/scpad && xdo show "$winclass"
  fi
fi
