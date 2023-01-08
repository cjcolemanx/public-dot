local setKey = vim.keymap.set
local global = vim.g

------------------------------
-- => Options
------------------------------
local remap = { remap = true }
local noremap = { remap = false }
local silent = { silent = true }

global.mapleader = ","
global.maplocalleader = ";"

------------------------------
-- => Mappings
------------------------------

-- Movement
setKey("", "J", "5j")
setKey("", "K", "5k")
setKey("", "0", "^")
setKey("", "<Bar>", "^i")

-- Better Shifting
setKey("", ">", ">l")
setKey("", "<", "<l")

-- Save + Exit
setKey("", "<leader>w", ":w!<CR>") -- Save Current
setKey("", "<leader>aw", ":wa!<CR>", silent) -- Save All
setKey("", "<leader>q", ":q<CR>") -- Quit Current
setKey("", "<leader>aq", ":qall<CR>", silent) -- Quit All

-- Terminal Shortcuts
setKey({ "n", "v" }, "<leader>t", ":terminal<CR>")
setKey("t", "<Escape>", "<C-\\><C-N>")

-- Possibly deprecated!

-- -- Window Management
-- setKey('', '<C-h>', '<C-w>h') -- Window Navigation ->
-- setKey('', '<C-j>', '<C-w>j')
-- setKey('', '<C-k>', '<C-w>k')
-- setKey('', '<C-l>', '<C-w>l')
-- setKey('', '<C-Space>l', ':vsplit<CR>') -- Vertical Split (L | R)
-- setKey('', '<C-Space>j', ':split<CR>')  -- Horizontal Split (T / B)
--
-- -- Window Resizing
-- setKey('', '<C-;>h', ':vertical resize +10<CR>')
-- setKey('', '<C-;>l', ':vertical resize -10<CR>')
-- setKey('', '<C-;>j', ':resize +5<CR>')
-- setKey('', '<C-;>k', ':resize -5<CR>')
-- setKey('', '<C-;>H', ':vertical resize +15<CR>')
-- setKey('', '<C-;>L', ':vertical resize -15<CR>')
-- setKey('', '<C-;>J', ':resize +10<CR>')
-- setKey('', '<C-;>K', ':resize -10<CR>')
--
-- -- Tabs
-- setKey('n', '<M-n>', ':tabnew<CR>', silent)
-- setKey('n', '<M-w>', ':tabclose<CR>', silent)
--
-- -- Buffers
-- setKey('n', '<M-h>', ':bprevious<CR>', silent)
-- setKey('n', '<M-l>', ':bnext<CR>', silent)
--
-- -- Logging
-- setKey('n', ';sm', ':mess<CR>') -- 'S'how 'M'essages
