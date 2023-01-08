#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$ranger_type/$ranger_style"

# Theme Elements
prompt='Launchers: Super + Space, then... '
mesg="Launch the associated Rofi menu (Scroll down for more)"

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
option_1="Super + m - MPD"
option_2="Super + v - Volume"
option_3="Super + s - Screenshot"
option_4="Super + l - Weblinks"
option_5="Super + h - Ranger a Folder"
option_6="Super + y - Open Personal Scripts"
option_7="Super + t - Tmux (outdated)"
option_8="Super + r - Restarter"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7\n$option_8" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
    bash  ~/.config/rofi/applets/bin/mpd.sh &
	elif [[ "$1" == '--opt2' ]]; then
    bash  ~/.config/rofi/applets/bin/volume.sh &
	elif [[ "$1" == '--opt3' ]]; then
    bash  ~/.config/rofi/applets/bin/screenshot.sh &
	elif [[ "$1" == '--opt4' ]]; then
    bash  ~/.config/rofi/applets/bin/quicklinks.sh &
	elif [[ "$1" == '--opt5' ]]; then
    bash  ~/.config/rofi/scripts/my-scripts/ranger.sh &
	elif [[ "$1" == '--opt6' ]]; then
    bash  ~/.config/rofi/scripts/my-scripts/shell_scripts.sh &
	elif [[ "$1" == '--opt7' ]]; then
    bash  ~/.config/rofi/scripts/my-scripts/tmux.sh &
	elif [[ "$1" == '--opt8' ]]; then
    bash  ~/.config/rofi/scripts/my-scripts/master_restarter.sh &
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
    $option_7)
		run_cmd --opt7
        ;;
    $option_8)
		run_cmd --opt8
        ;;
esac
