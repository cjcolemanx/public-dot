#!bin/sh
ID=$(bspc query -N -n)
bspc node $ID -n $(bspc query -N -n .leaf.\!window)
