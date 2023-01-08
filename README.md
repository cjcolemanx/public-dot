# Dotfiles

Don't expect a lot of stability here. I tinker with this constantly.

## Dependencies

- Window Manager: bspwm + sxhkd
- Shell: ZSH (w/ Oh-My-Zsh and Starship)
- Text Editor: NeoVim and VSCodium
- Widgets and Bars: Rofi, Eww, and Polybar
- Terminal Emulator: Kitty
- Screenshots: Flameshot (wanna look into Scrot tho)
- Notifications: Dunst
- Wallpapers: Nitrogen
- Compositor: Picom
- Clipboard: Clipmenu

### Notes

Some Alacritty stuff is sprinkled around these configs, but I've moved to Kitty
p much. I don't have any real Kitty configs yet, I've only been using it for a couple
of weeks.

Similarly for Tmux: Kitty does 90% of what I need so tmux files are kind of
redundant now.

Eww is probably the newest addition to this ecosystem, so it's the least fleshed
out.

My Polybar, Eww, and Rofi folders contain a lot of stuff from various other
repos (that I didn't author) so it can be pretty confusing to parse. As far as
_which_ of those configs I use/wrote, check these files and folders:

- 'polybar/grayblocks'
- 'rofi/scripts/myscripts'
- ... and eww is just a mess rn

Widgets and Dunst are launched/killed with either a keybind or they're part of the `baspwmrc` file.

## The Medium One

BSPWM + SXHKD.

Includes a script for launching a scratchpad terminal.

I made it a personal rule to only use `Super` in global operations (crazy), so
every command in the `sxhkdrc` will begin with that key.

Rofi menus are accessed via a set of `Super + Space` then `Super + <X>` -type
commands.

## The Big One

NeoVim config.

Nightmare mode.

There's some old, useless config definitions in the `lua/plugin` directory when
I was working on this idea of "custom, declarative instances" using vim globals
and command line arguments, but you can get 90% of what you need just from autocmds
and Snippets, so just ignore everything outside of the `dev` folder and
`packer.lua`.

Integration options w/ VSCodium's NeoVim extension exist, but I don't _really_
use VSCodium for anything now.

All plugin configurations are in `after/plugin`.

All keymaps are in `lua/keymaps`. `global-keymaps` don't have any dependencies
and are loaded automatically.

`plugin-keymaps` are essentially containers for
various plugin-related bindings. These get used in the plugin setup
functions in `after/plugin`.

---

Snippets are in `.lua` format in `snippets`. All the current snippets are my
own, but you can find more online. Be careful, I have a lot of autosnippets

Custom Telescope pickers are in `lua/ui/pickers`

I also wrote a little function that makes the dashboard grab a random piece of
ASCII art for the logo and display image (text is dynamic too!) on launch, so if
its fugly, that's why. It's random lol. Sometimes you get a masterpiece like the
Notepad logo + Garfield, so it's aesthetically consistent with the state of
these files.

Some notable plugins/features:

- nvim-telescope: I love nvim-telescope. I have too many keybinds nvim-telescope
  let's me make even more : )
- LSP: mason, mason-lspconfig, null-ls, and nvim-lspconfig
- nvim-tree: I have a LOT of custom functionality here
- nvim-web-devicons
- Completion via nvim-cmp
- Treesitter
- Diagnostics: trouble
- Motions: nvim-surround, tabout.nvim, Comment.nvim, and leap.nvim
- Tabline and Statusline: tabby.nvim, lualine.nvim
- Notifications: nvim-notify, fidget.nvim (for in-buffer status for LSP)
- Folds: Ufo (still configuring this one)
- which-key.nvim: Documentaion for keybinds (I have not been a very good keybind
  document-er)
- Documentation viewing: LSPSaga, nvim-telescope

Some stuff I may start/stop using soon:

- Shade.nvim - Hates funny buffer operations. Can likely replicate the behavior
  with an aucommand anyway
- Drop.nvim - needs an opaque background, but also busts nvim-tree buffers
- link-visitor.nvim - hasn't broken anything yet, but works 1/3 of the time.
  Probably my fault
- which-key - doesn't fit my personal philosophy on contextual, flowmap-styled keybinds.
  It _could_ but it's really hard to make it work like I _really_ want.
- neotest: integrated testing tools, just haven't set it up yet

### Completion

- buffer
- path
- commands
- NerdFont glyphs
- Snippets with LuaSnip

### Color Schemes

> NOTE: The opacity of Nvim is based on the opacity settings of your terminal
> emulator. If you use the Nvim GUI, then you don't have to worry about that kind
> of stuff.

I use `nightfox.nvim` with the `duskfox` palette. It's a nice,
not-too-dark-or-bright dark theme with a green tint.

There's also...

- tokynight
- gruvbox-material (less straining Gruvbox, my old favorite)
- neosolarized
- vim-substrata
- tender
- lush
- nvim-base16 (base16 color scheme collection, check `lua/ui/look`)

### Custom Telescopes: `lua/ui/pickers`

> Note: Most of these are half-finished. The tabs picker one in particular encompasses
> logic I'd like to extract to a regular keybind.

The default options for each are in the `defaults` folder.

- journal-picker: personal notes and stuff
- session-picker: I hated every session management plugin, so I built a simpler
  interface. Saves sessions to `~/.config/nvim/sessions/`
- tab-manager: tab-switching and reordering
- config-files: for quick editing nvim config files
- highlight-picker: helper for high-str.nvim

## Other stuff I use

- MPD w/ NCMPCPP (pavucontrol to swap headsets)
- VLC
- Ranger
- Zathura
- Discord Canary
- Brave
