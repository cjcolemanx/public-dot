# NeoVim Config

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
