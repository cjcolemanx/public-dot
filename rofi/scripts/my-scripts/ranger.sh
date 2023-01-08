#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$ranger_type/$ranger_style"

# Theme Elements
prompt='Open Folder'
mesg="Opens in Ranger (Quitting exits Kitty)"
more_options_up="(scroll) "
more_options_down="(scroll) "

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
#################################################### <- max line length (before trim)
########################################$     <- padding
option_1=" Home                         "
option_2=" HDD A                                   "
option_3=" Projects                                "
option_4=" Repos                                   "
option_5=" Config                                  "
option_6=" Scripts                      "
########################################$     <- padding
option_7=" Pictures                     "
option_A=" System Etc                              "
option_B=" System Sys                   "

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
	# echo -e "$option_1 $more_options_up
 #    \n$option_2\
 #    \n$option_3\
 #    \n$option_4\
 #    \n$option_5\
 #    \n$option_6 $more_options_down\
 #    \n$option_7 $more_options_up\
 #    \n$option_A $more_options_down\
 #    \n$option_B $more_options_down" | rofi_cmd
	echo -e "$option_1 $more_options_up
$option_2
$option_3
$option_4
$option_5
$option_6 $more_options_down
$option_7 $more_options_up
$option_A
$option_B $more_options_down" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		kitty -e ranger $HOME
	elif [[ "$1" == '--opt2' ]]; then
		kitty -e ranger /mnt/A
	elif [[ "$1" == '--opt3' ]]; then
		kitty -e ranger $HOME/Projects
	elif [[ "$1" == '--opt4' ]]; then
		kitty -e ranger $HOME/Repos
	elif [[ "$1" == '--opt5' ]]; then
		kitty -e ranger $HOME/.config
	elif [[ "$1" == '--opt6' ]]; then
		kitty -e ranger $HOME/bin
	elif [[ "$1" == '--opt7' ]]; then
		kitty -e ranger /mnt/A/pictures
	elif [[ "$1" == '--optA' ]]; then
		kitty -e ranger /etc
	fi
}

# Actions
# NOTE: No way to prevent manually configuration on this atm. 
chosen="$(run_rofi)"
case ${chosen} in
    "$option_1 $more_options_down")
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
    "$option_6 $more_options_down")
		run_cmd --opt6
        ;;
    "$option_7 $more_options_up")
		run_cmd --opt7
        ;;
    $option_A)
		run_cmd --optA
        ;;
esac
