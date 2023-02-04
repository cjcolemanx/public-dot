#
# ~/.bashrc
#

[[ -f "$HOME/.config/shell/.aliases" ]] && source "$HOME/.config/shell/.aliases"
[[ -f "$HOME/.config/shell/.funcs" ]] && source "$HOME/.config/shell/.funcs"
[[ -f "$HOME/.config/shell/.env" ]] && source "$HOME/.config/shell/.env"
[[ -f "$HOME/.config/shell/.sources" ]] && source "$HOME/.config/shell/.sources"
[[ -f "$HOME/.config/bash/.bash_aliases" ]] && source "$HOME/.config/bash/.bash_aliases"
[[ -f "$HOME/.config/bash/.bash_options" ]] && source "$HOME/.config/bash/.bash_options"
[[ -f /usr/share/bash-completion/bash_completion ]] &&
	. /usr/share/bash-completion/bash_completion

# Splashscreen
archey3

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init bash)"

# Completions
eval "$(zoxide init bash)"
