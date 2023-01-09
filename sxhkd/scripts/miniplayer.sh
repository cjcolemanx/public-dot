#!/bin/bash

# ID Miniplayer
winclass="$(xdotool search --class 'mpdplayer')"

# If Miniplayer doesn't exist...
if [ -z "$winclass" ]; then
	kitty --class mpdplayer --name 'Miniplayer' miniplayer #--session ./miniplayer-session
else
	# If Miniplayer doesn't exist, create it and hide terminal
	if [ ! -f /tmp/mpdplayer ]; then
		touch /tmp/mpdplayer && xdo hide "$winclass"
	# If Miniplayer does exist, remove it and show terminal
	elif [ -f /tmp/mpdplayer ]; then
		rm /tmp/mpdplayer && xdo show "$winclass"
	fi
fi
