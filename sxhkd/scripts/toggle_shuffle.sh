#! /bin/bash
# NOTE: I don't use playerctl w/ cmus anymore
curStat=$(playerctl shuffle)

if [ $curStat = On ]; then
  playerctl shuffle Off
else
  playerctl shuffle On
fi
