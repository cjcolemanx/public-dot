local setKey = vim.keymap.set
local api_keymap = vim.api.nvim_set_keymap
local global = vim.g

-- Helpers
-- local helpers_status, helpers = pcall(require, "global.functions")
-- if not helpers_status then
--   print("error in lua.global configs: can't find helpers")
-- end

------------------------------
-- => Options
------------------------------
local remap = { remap = true }
local noremap = { remap = false }
local silent = { silent = true }
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

global.mapleader = ","
global.maplocalleader = ";"
global.script_leader = "_"

------------------------------
-- => Mappings
------------------------------

-- Movement (just a lil faster)
setKey("", "J", "5j")
setKey("", "K", "5k")
-- setKey("", "H", "3B")
-- setKey("", "L", "3W")
setKey("", "0", "^")
setKey("", "<Bar>", "^i")

-- Space Is Useful : )
setKey("n", "<Space>c", "ciw", remap)
setKey("n", "<Space>d", "diw", remap)
setKey("n", "<Space>D", "dd", remap)
setKey("n", "<Space>y", "yiw", remap)
setKey("n", "<Space>Y", "yy", remap)
setKey("n", "<Space>m", "mz", remap)
setKey("n", "<Space>f", "/", remap)
setKey("n", "<Space>e", "`z", remap)
setKey("n", "<Space>j", "zb", remap)
setKey("n", "<Space>k", "zt", remap)
setKey("n", "<Space>l", "zz", remap)
setKey("n", "<Space>i", "ci", remap) -- "ci" + whatever
setKey("n", "<Space>wl", ":vsplit<CR><C-l>", remap)
setKey("n", "<Space>wj", ":split<CR><C-j>", remap)

-- Line Ordering
setKey("n", "<M-k>", "ddkP", remap)
setKey("n", "<M-j>", "ddp", remap)
setKey("x", "<M-k>", "dkkP", remap) -- NOTE: doesn't work quite right
setKey("x", "<M-j>", "dp", remap) -- NOTE: doesn't work quite right

-- Better Shifting
setKey("", ">", ">l")
setKey("", "<", "<l")

-- Save + Exit
setKey("", "<leader>w", ":w!<CR>") -- Save Current
setKey("", "<leader>we", ":wa!<CR>", silent) -- Save All
setKey("", "<leader>q", ":q<CR>") -- Quit Current
setKey("", "<leader>Q", ":q!<CR>") -- Quit Current
setKey("", "<leader><Space>q", ":qall<CR>", silent) -- Quit All
setKey("", "<leader><Space>Q", ":qall!<CR>") -- Quit All

-- Window Management
setKey("n", "<C-h>", "<C-w>h") -- Window Navigation ->
setKey("n", "<C-j>", "<C-w>j")
setKey("n", "<C-k>", "<C-w>k")
setKey("n", "<C-l>", "<C-w>l")
setKey("n", "<C-g>", "<C-W>r")
setKey("n", "<leader>sj", "<C-W>J")
setKey("n", "<leader>sk", "<C-W>K")
setKey("n", "<leader>sh", "<C-W>H")
setKey("n", "<leader>sl", "<C-W>L")
setKey("n", "<leader>s<Space>", "<C-W>x")
setKey("n", "<leader>sr", "<C-W>r")
setKey("n", "<leader>dl", ":vsplit<CR>") -- Vertical Split (L | R)
setKey("n", "<leader>dj", ":split<CR>") -- Horizontal Split (T / B)

-- Prompt for Window Focus
setKey("n", "<leader>f", ":sbuffer ")
setKey("n", "<M-h>", "<C-w>R") -- Rotate backwards
setKey("n", "<M-l>", "<C-w>r") -- Rotate forwards
-- setKey("n", "<M-l>", "<C-w>r") -- Rotate forwards
-- NOTE: Try out the 'Exchange' version
-- setKey("n", "<M-h>", "<C-w>X") -- Rotate backwards
-- setKey("n", "<M-l>", "<C-w>x") -- Rotate forwards
setKey("n", "-", function()
  local quick_switch_window = require("behavior.commands.window-commands").window_switcher
  quick_switch_window()
  -- if vim.v.count == 0 then
  -- 	return
  -- end
  -- swap_func(vim.v.count)
end)
setKey("n", "<C-a>", function()
  print(vim.api.nvim_buf_get_name(0))
end)

-- Window Resizing
-- setKey('', '<C-;>h', ':vertical resize +10<CR>')
setKey("", "RL", ":vertical resize -10<CR>")
setKey("", "RH", ":vertical resize +10<CR>")
setKey("", "RJ", ":resize +5<CR>")
setKey("", "RK", ":resize -5<CR>")
-- setKey('', '<C-;>H', ':vertical resize +15<CR>')
-- setKey('', '<C-;>L', ':vertical resize -15<CR>')
-- setKey('', '<C-;>J', ':resize +10<CR>')
-- setKey('', '<C-;>K', ':resize -10<CR>')

-- Tabs
setKey("n", "ta", ":tabnew<CR>:tabm<CR>", silent)
setKey("n", "tc", ":tabclose<CR>", silent)
setKey("n", "tn", ":tabprevious<CR>", silent)
setKey("n", "<Space>tn", ":tabprevious<CR>", silent)
setKey("n", "tp", ":tabnext<CR>", silent)
setKey("n", "<Space>tp", ":tabnext<CR>", silent)
setKey("n", "th", ":tabprevious<CR>", silent)
setKey("n", "tl", ":tabnext<CR>", silent)
setKey("n", "tsh", ":tabm -1<CR>", silent)
setKey("n", "tsl", ":tabm +1<CR>", silent)

-- Buffers
-- setKey("n", "<M-h>", ":bprevious<CR>", silent)
setKey("n", "<Space>[", ":bprevious<CR>", silent)
-- setKey("n", "<M-l>", ":bnext<CR>", silent)
setKey("n", "<Space>]", ":bnext<CR>", silent)
setKey("n", "<leader>gb", function()
  local b = vim.fn.bufnr()
  vim.fn.setreg("B", b)
end, silent)
setKey("n", "<leader>pb", function()
  local b = vim.fn.getreg("B")
  vim.cmd("b " .. b)
end, silent)

-- Logging
setKey("n", ";sm", ":mess<CR>") -- 'S'how 'M'essages

-- Terminal Shortcuts
-- setKey({ "n", "v" }, "<leader>t", ":terminal<CR>")
setKey({ "n", "v" }, "<C-T>", ":terminal<CR>")
setKey("t", "<Escape>", "<C-\\><C-N>")

-- Searching
setKey("", "<leader>/", ":nohl <CR>", silent)

-- NOTE: deprecated b/c ui pickers
-- setKey("n", "_ms", "<cmd>mks! ~/.config/nvim/sessions/temp.vim<cr>")
-- setKey("n", "r>rs", "<cmd>source ~/.config/nvim/sessions/temp.vim<cr>")

-- Quick View
setKey("n", "<leader>2", "<cmd>mess <cr>")

-- Formatting and View
setKey("n", "<C-.>", "")

-- Re-Source Config
setKey("n", ";<Tab>r", "", {
  silent = true,
  desc = "reload init.lua",
  callback = function()
    vim.cmd([[
    update ~/.config/nvim/init.lua
    source ~/.config/nvim/init.lua
    ]])
    require("notify").notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
  end,
})
setKey("n", ";<Tab>o", "", {
  silent = true,
  desc = "reload plugin config",
  callback = function()
    vim.cmd([[
    update ~/.config/nvim/after/plugin/_after.lua
    source ~/.config/nvim/after/plugin/_after.lua
    ]])
    require("notify").notify(
      "Nvim _after.lua successfully reloaded!",
      vim.log.levels.INFO,
      { title = "nvim-config" }
    )
  end,
})

-- Fix popup lingering
setKey("n", ",<Tab>", ":popup_clear(1)<CR>", silent)

-- Copy + Paste to system clipboard
-- FIXME: run :h clipboard for more info
-- api_keymap("n", "<c-c>", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
-- api_keymap("n", "<c-v>", '"+p', {noremap=true, silent=true})

-------------------------
-- => Directories + Workflow
-------------------------
--[[
% : current file
h : filename modifier "dirname"
--]]
-- Change directory for current buffer
setKey(
  "n",
  "<Leader>cd",
  function()
    vim.cmd({ cmd = "lcd", args = { "%:h" } })
    print("Changed local cd")
  end,
  -- ":lcd %:h<CR>",
  silent
)

-------------------------
-- => Meta Stuff
-------------------------
setKey("n", "<m-y>", function()
  print("TODO: Create Vim Info Yanker")
end)

------------------------------
-- => Debug
------------------------------
setKey("i", "<m-h>", "<esc>dBxi", silent)

-- setKey("n", "<leader><space>di", vim.inspect())
setKey("n", "<leader><space>di", function()
  print(vim.inspect(vim.api.nvim__stats()))
end)

-------------------------
-- => Function Keys
-------------------------
setKey("n", "<F3>", ":checkhealth<CR>")

-------------------------
-- =>  Insert Mode
-------------------------
setKey("i", "<C-s>", "<ESC>:w!<CR>i", silent) -- Save Current (in insert)

------------------------------
-- => Unmap
------------------------------
setKey("i", "<c-j>", "", noremap)
setKey("i", "<c-h>", "", noremap)
