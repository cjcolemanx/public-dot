#!/bin/bash
CONFIG_DIR=$HOME/.config

arr_folders=(
	"alacritty"
	"bash"
	"bspwm"
	"eww"
	"git"
	"i3"
	"kitty"
	"i3blocks"
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
	rm -rf ./"$i"
	echo "Copying $i"
	cp -r "$CONFIG_DIR/$i" ./
done

cp "$HOME/bin/keybinds.sh" ./keybinds.sh

# Cleanup
rm -rf nvim/data/project-locations.txt
rm -rf nvim/.mind
