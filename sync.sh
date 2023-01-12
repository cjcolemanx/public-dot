#!/bin/bash
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

# Just delete the folders in here, grab the new ones
for i in "${arr_folders[@]}"; do
	rm -r ./"$i"
	echo "Copying $i"
	cp -r "$CONFIG_DIR/$i" ./
done
