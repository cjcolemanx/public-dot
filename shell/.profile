# ### => PATH and sourcing
# . "$HOME/.cargo/env"

# Add my Scripts
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# Set colors with pywal
if [ -f "$HOME/.cache/wal/sequences" ]; then
	cat "$HOME/.cache/wal/sequences"
fi
