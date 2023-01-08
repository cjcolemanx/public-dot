#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$tmux_type/$tmux_style"

# Theme Elements
prompt='Open tmux session'
mesg=""

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
# option_1=" Music Player"
# option_2=" Notes/Agenda"
# option_3=" Configs"
option_1=""
option_2=""
option_3=""
option_4="亮"

# Toggle Actions
active=''
urgent=''

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "Tmux";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
    kitty --class musicKitty --session ~/.config/kitty/music.session
		# kitty -e tmux new -s $$ 'tmux source-file ~/.config/ncmpcpp/tsession' 
		# kitty tmux new -s $$ 'tmux source-file ~/.config/ncmpcpp/tsession' 
		# alacritty -t 'Music' -e tmux new -s $$ 'tmux source-file ~/.config/ncmpcpp/tsession' 
		# alacritty -e tmux new 'ncmpcpp ~/.config/ncmpcpp/tsession' -s 'Music'
		# alacritty -e tmux -f ~/.config/ncmpcpp/tsession
	elif [[ "$1" == '--opt2' ]]; then
		alacritty -t 'Agenda + Notes' -e tmux new -s $$ 'tmux source-file ~/.config/tmux/sessions/t_personal' 
	elif [[ "$1" == '--opt3' ]]; then
    alacritty -t '(Edit) Configs' -e tmux new -s $$ 'tmux source-file ~/.config/tmux/sessions/t_edit_configs' 
	elif [[ "$1" == '--opt4' ]]; then
    alacritty -t '(Edit) Scripts' -e tmux new -s $$ 'tmux source-file ~/.config/tmux/sessions/t_edit_scripts' 
	# elif [[ "$1" == '--opt5' ]]; then
 #    rofi -show find -modi "Find File:~/.scripts/utility/search_files.sh" &
	# elif [[ "$1" == '--opt6' ]]; then
 #    rofi -show find -modi "Find File:~/.scripts/utility/man_search.sh" &
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
    mesg="Music"
        ;;
    $option_2)
		run_cmd --opt2
    mesg="Agenda and Notes"
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
