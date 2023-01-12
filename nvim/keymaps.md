# Navigation and Geting Around

Most regular Vim keys will work as expected; only in instances of
operator characters that have no default function (like "t" and, mostly, "g")
will these keys be mapped. With the exception of "s".

The Leader Key is "comma" (,), but I also have mappings for "semicolon" (;) and
"space".

Mnemonics are included where appropriate (and excluded where there is no good
reason ლ(´ڡ`ლ) )

## Basic Movement

"J" - Move 5 lines down

"K" - Move 5 lines up

"0" - Go to first non-blank character

"|" - Go to first non-blank character, enter insert mode (like a backwards "A")

"<leader>/" - Disable search highlights

## Windows

"<C-h> OR <C-l>" - Change window left/right

"<C-j> OR <C-k>" - Change window up/down

### Window Management

"<C-g>" - Rotate windows Clockwise (doesn't work in uneven layouts, and need at least
2 windows)

"<leader>s THEN h,j,k,l" - "Send" window to top-, bottom-, left-, or right-most
side of screen

"<leader>s<Space>" - "Send to Space", Rotate windows horizontally (I rarely use
this, and it confuses me normally. Only good for few windows)

"<leader>f" - "Focus"; Quick switch to buffer by number (have to know buffers. If using
my Lualine config, it's next to the mode indicator when a window is focused or
it's the furthest right indicator)

"<M-h>" - Rotate Windows backwards

"<M-l>" - Rotate Windows forwards

"-" - Open custom window picker (w/ custom UI popups)

### Resizing

"RL" - Resize horizontally (decrease)

"RH" - Resize horizontally (increase)

"RJ" - Resize vertically (increase)

"RK" - Resize vertically (decrease)

## Tabs

"ta" - "Tab Add" create a new tab and focus it

"tc" - "Tab Close" close the current tab

"tl" - "Tab Next" go to next tab

"th" - "Tab Previous" go to next tab

"tsl" - "Tab Swap Next" swap tab at -1 index with current

"tsh" - "Tab Swap Next" swap tab at +1 index with current

## Space Alia(en)s

"<Space>m" - Alias: "mz" - create a quick mark at `z`

"<Space>e" - Alias: "`z" - go to quick mark at `z`

"<Space><j/k/l>" - Alias: "z" + b/t/z - move current line to bottom/top/center of

screen

"<Space>f" - Alias: "/" - enter search (easier on the hands)

"<Space>/" - Disables highlighting for search terms

"<Space>]" - Alias: "<C-]>" - go to next tag (nice for help docs)

> Note: the following use the remapped <C-key> window movement (defined above)

"<Space>wh" - Alias: ":vsplit <C-h>" - Split vertically (L | R)

"<Space>wl" - Alias: ":vsplit <C-l>" - Split vertically

"<Space>wk" - Alias: ":split <C-k>" - Split horizontally (T / B)

"<Space>wj" - Alias: ":split <C-j>" - Split horizontally

"<Space>p" - Alias: ":bufnext" - Go to next buffer

"<Space>n" - Alias: ":bufprevious" - Go to previous buffer

# Editing

Some of these are just shorthand for quick ops. Saves keystrokes, saves double
presses. Sometimes I just don't like how something feels 🤷

## Basic Editing

"<Alt-k>" - Move current line/selection up one row (normal and visual only)

"<Alt-j>" - Move current line/selection down one row (normal and visual only)

">" - Add one tab to BOL

"<" - Remove one tab from BOL

> Note: This next one isn't perfect, since you're at he whims of the autoformatter. It's
> essentially just a quick jump to Normal mode, save, then "a" into your previous
> cursor position

"<C-s>" - save current buffer and re-enter insert at pre-save location

# Leaving NeoVim

"<leader>w" - Save current buffer

"<leader>we" - Save open all buffers

"<leader>q" - Exit current buffer

"<leader>Q" - Exit current buffer without saving

"<leader><Space>q" - Exit all buffers

"<leader><Space>Q" - Exit all buffers without saving

## Space Alia(en)s

"<Space>c" - Alias: "Ciw" - change in word

"<Space>d" - Alias: "diw" - delete in word

"<Space>D" - Alias: "DD" - deletes a line

# Terminal

"<Escape>" - Leave terminal

"<C-t>" - Open Terminal

# Vim Status and Utility

"<leader>2" - View vim messages

"<F3>" - run `checkhealth`

"<leader><Tab>" - Clear any popups from the screen

"<leader>cd" - Change lcd to the current buffer's directory

# Plugins

These are the plugin dependent keybinds.

## CMP (Completion)

"<C-j> AND <down>" - Highlight next suggestion

"<Alt-j>" - Highlight 3 suggestions down

"<C-k> AND <up>" - Highlight next suggestion

"<Alt-k>" - Highlight 3 suggestions up

"<C-u>" - Scroll cmp hoverdoc up

"<C-d>" - Scroll cmp hoverdoc down

## UFO (Folds)
