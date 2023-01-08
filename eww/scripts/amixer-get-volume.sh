#!/bin/bash
master_status=$(amixer 'get' 'Master' | grep 'Front Left: Playback' | cut -d "[" -f 2 | cut -d "%" -f 1)
echo "$master_status"
