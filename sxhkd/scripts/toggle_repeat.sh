#! /bin/bash
# NOTE: I don't use playerctl w/ cmus anymore
curStat=$(playerctl loop)

if [ $curStat = None ]; then
  playerctl loop Playlist
elif [ $curStat = Playlist ]; then
  playerctl loop Track
else
  playerctl loop None
fi
