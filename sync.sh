#!/bin/sh
CONFIG_DIR=$HOME/.config

arr_folders=( 
  "bash" 
  "bspwm"
  "eww"
  "git"
  "nvim"
  "polybar"
  "rofi"
  "shell"
  "starship"
  "sxhkd"
  "zsh"
)

for i in "${arr_folders[@]}" 
do
  echo "Copying $i"
  cp -r "$CONFIG_DIR/$i" ./
done

