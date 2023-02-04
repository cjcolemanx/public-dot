#! /usr/bin/sh
BSPWM_HIDDEN_DB="/tmp/bspwm_hidden_windows"
bspc query -N -n .hidden | tail -n1 >"$BSPWM_HIDDEN_DB"
