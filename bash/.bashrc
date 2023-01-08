#
# ~/.bashrc
#

[[ -f ~/.config/bash/.bash_options ]] && . ~/.config/bash/.bash_options
[[ -f ~/.config/bash/.bash_aliases ]] && . ~/.config/bash/.bash_aliases
[[ -f ~/.config/shell/.aliases ]] && . ~/.config/shell/.aliases
[[ -f ~/.config/shell/.funcs ]] && . ~/.config/shell/.funcs
[ -f ~/.config/shell/.sources ] && . ~/.config/shell/.sources
[[ -f /usr/share/bash-completion/bash_completion ]] && \
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
. "$HOME/.cargo/env"
