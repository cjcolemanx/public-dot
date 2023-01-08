#!/bin/sh

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_aur))

### Uncomment to make module appear dynamically
if [ "$updates" -gt 0 ]; then
    # echo "%{T4}AUR 📦️%{T-}$updates"
    echo $updates
else
    echo ""
fi

