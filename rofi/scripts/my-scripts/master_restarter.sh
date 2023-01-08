#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$ranger_type/$ranger_style"
polybar_loc="$HOME/.config/polybar/grayblocks/config.ini"

# Theme Elements
prompt='Select Process'
mesg="Relaunch the selected process"

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-5'* ) ]]; then
	efonts="JetBrains Mono Nerd Font 10"
else
	efonts="JetBrains Mono Nerd Font 28"
fi

# Options
option_1="Sxhkd"
option_2="Polybar"
option_3="Eww"
option_6="Bspwm"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		alacritty -t "Restarting SXHKD" -e killall -q sxhkd 
    sxhkd &
    notify-send -a "Master Restarter Rofi" "Sxhkd Reloaded" 
	elif [[ "$1" == '--opt2' ]]; then
		alacritty -t "Restarting Polybar" -e killall -q polybar 
    # polybar -q -c $polybar_loc main &
    # polybar -q -c $polybar_loc main2 &
    bash ~/.config/polybar/launch.sh --grayblocks &
    notify-send -a "Master Restarter Rofi" "Polybar Reloaded" 
	elif [[ "$1" == '--opt3' ]]; then
    alacritty -t "Restarting Eww" -e eww kill
    # eww open sidebar
    notify-send "Eww Reloaded"
	elif [[ "$1" == '--opt6' ]]; then
    alacritty -t "Restarting Bspwm" -e bspc wm -r
    notify-send  -a "Master Restarter Rofi" "Bspwm Reloaded"
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
