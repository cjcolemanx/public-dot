#!/bin/sh

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

updates=$((updates_arch ))

## Uncomment to make module appear dynamically
if [ "$updates" -gt 0 ]; then
    # echo "|%\{T4}ARC 📦️%\{T-}$updates"
  echo $updates
else
    echo ""
fi
