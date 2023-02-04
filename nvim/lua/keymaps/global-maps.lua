local setKey = vim.keymap.set
local api_keymap = vim.api.nvim_set_keymap
local api = vim.api
local global = vim.g

-- Helpers
-- local helpers_status, helpers = pcall(require, "global.functions")
-- if not helpers_status then
--   print("error in lua.global configs: can't find helpers")
-- end
local function this_window()
	return api.nvim_win_get_config(0)
end

local function this_buffer()
	local all_options = api.nvim_get_all_options_info()
	local win_number = api.nvim_get_current_win()
	local v = vim.wo[win_number]
	local all_options = api.nvim_get_all_options_info()
	local res_as_string = ""
	local res_as_table = {}

	for key, val in pairs(all_options) do
		if val.global_local == false and val.scope == "win" then
			res_as_string = res_as_string .. "|" .. key .. "=" .. tostring(v[key] or "<not set>") .. "\n"
			local table_str = key .. "=" .. tostring(v[key] or "<not set>")
			table.insert(res_as_table, table_str)
		end
	end
	return {
		str = res_as_string,
		table = res_as_table,
	}
end

-- local function this_tabpage()
--   return api.nvim_win_get_config(0)
-- end

------------------------------
-- => Options
------------------------------
local remap = { remap = true }
local noremap = { remap = false }
local silent = { silent = true }
local sn = { silent = true, remap = false }
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

-- FIXME: Utilize globals in keybindings
global.mapleader = ","
global.map_alt_leader = ";"
global.script_leader = "_"

------------------------------
-- => Mappings
------------------------------
-- TODO:
-- Show diff in split
-- setKey("n", "<Space>dl", ":w !diff % -<CR>", remap)

-- Movement (just a lil faster)
setKey("", "J", "5j")
setKey("", "K", "5k")
setKey("", "0", "^")
setKey("", "<Bar>", "^i")

-- Yankin'
setKey("n", "<Leader>ya", ":%y<CR>", { noremap = false, silent = true })

-- MAKE (Space)
-- Space Is Useful : )
setKey("n", "<Space>c", "ciw", remap)
setKey("n", "<Space>d", "diw", remap)
setKey("n", "<Space>D", "dd", remap)
setKey("n", "<Space>Y", "yiw", remap)
setKey("n", "<Space>y", "yy", remap)
setKey("n", "<Space>m", "mz", remap)
setKey("n", "<Space>e", "`z", remap)
-- setKey("n", "<Space>f", "/", remap)
-- setKey("n", "<Space>/", "<CMD>nohl<CR>", sn)
setKey("n", "<Space>j", "zb", remap)
setKey("n", "<Space>k", "zt", remap)
setKey("n", "<Space>l", "zz", remap)
setKey("n", "<Space>]", "<C-]>", remap) -- Using already
setKey("n", "<Space>wl", ":vsplit<CR><C-l>", remap)
setKey("n", "<Space>wh", ":vsplit<CR>", remap)
setKey("n", "<Space>wj", ":split<CR><C-j>", remap)
setKey("n", "<Space>wk", ":split<CR>", remap)
setKey("n", "<Space>n", ":bprevious<CR>", silent)
setKey("n", "<Space>p", ":bnext<CR>", silent)
setKey("n", "<Space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Line Ordering
setKey("n", "<M-k>", "ddkP", remap)
setKey("n", "<M-j>", "ddp", remap)
setKey("v", "<M-j>", ":m '>+1<CR>gv=gv")
setKey("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Better Shifting
setKey({ "n", "v" }, ">", ">l")
setKey({ "n", "v" }, "<", "<l")

-- Better Scrolling and Searching
setKey("n", "<C-d>", "<C-d>zz")
setKey("n", "<C-u>", "<C-u>zz")
setKey("n", "n", "nzzzv")
setKey("n", "N", "Nzzzv")

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

-- Prompt for Window Focus
setKey("n", "<leader>f", ":sbuffer ")
setKey("n", "<M-h>", "<C-w>R") -- Rotate backwards
setKey("n", "<M-l>", "<C-w>r") -- Rotate forwards
setKey("n", "-", function()
	local quick_switch_window = require("behavior.commands.window-commands").window_switcher
	quick_switch_window()
end)

-- Window Resizing
setKey("", "RL", ":vertical resize -10<CR>")
setKey("", "RH", ":vertical resize +10<CR>")
setKey("", "RJ", ":resize +5<CR>")
setKey("", "RK", ":resize -5<CR>")

-- Tabs
setKey("n", "ta", ":tabnew<CR>:tabm<CR>", silent)
setKey("n", "tc", ":tabclose<CR>", silent)
setKey("n", "th", ":tabprevious<CR>", silent)
setKey("n", "tl", ":tabnext<CR>", silent)
setKey("n", "tsh", ":tabm -1<CR>", silent)
setKey("n", "tsl", ":tabm +1<CR>", silent)

-- TODO: Buffers
-- setKey("n", "<leader>gb", function()
-- 	local b = vim.fn.bufnr()
-- 	vim.fn.setreg("B", b)
-- end, silent)
-- setKey("n", "<leader>pb", function()
-- 	local b = vim.fn.getreg("B")
-- 	vim.cmd("b " .. b)
-- end, silent)

-- Terminal Shortcuts
-- setKey({ "n", "v" }, "<leader>t", ":terminal<CR>")
-- setKey({ "n", "v" }, "<C-T>", ":terminal<CR>")
-- setKey("t", "<Escape>", "<C-\\><C-N>")

-- Searching
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")

-- TODO: document
local function toggle_hlsearch(char)
	if vim.fn.mode() == "n" then
		local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
		local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

		if vim.opt.hlsearch:get() ~= new_hlsearch then
			vim.opt.hlsearch = new_hlsearch
		end
	end
end

vim.on_key(toggle_hlsearch, ns)

-- Quick View
-- setKey("n", "<leader>2", "<cmd>mess <cr>")
setKey("n", "<Space>2", "<cmd>mess <cr>")

-- Fix popup lingering
-- Works for notifications and choice node pop-ups
setKey("n", ",<Tab>", function()
	choice_popup_close()
	require("notify").dismiss()
end, silent)

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
	"<Leader>cdl",
	function()
		vim.cmd({ cmd = "lcd", args = { "%:p:h" } })
		print("Changed local cd for this window")
	end,
	-- ":lcd %:h<CR>",
	silent
)

setKey("n", "<leader>cdg", function()
	vim.cmd(":Glcd")
	print("Changed local cd to Git directory")
end)

-------------------------
-- => Meta Stuff
-------------------------
setKey("n", "<m-y>", function()
	print("TODO: Create Vim Info Yanker")
end)

------------------------------
-- => Debug
------------------------------
-- setKey("i", "<m-h>", "<esc>dBxi", silent)
-- setKey("i", ",buf", function()
-- 	print(vim.cmd("set buftype?"))
-- 	-- print(vim.cmd("set filetype?"))
-- end)

setKey(
	"n",
	"<leader><leader>vima",
	[[<Cmd>new<bar>put =execute('lua print(vim.inspect(vim))')
<CR>]],
	{ noremap = true, silent = true }
)

setKey("n", "<leader><leader>vimw", function()
	local window_config = this_window()
	local to_print = {}

	for s in vim.inspect(window_config):gmatch("[^\n]+") do
		table.insert(to_print, s)
	end

	vim.cmd("new")
	api.nvim_buf_set_text(0, 0, 0, 0, 0, to_print)
end, { noremap = true, silent = true })

setKey("n", "<leader><leader>vimb", function()
	local buf_opts = this_buffer().table
	local to_print = {}

	-- for s in vim.inspect(window_config):gmatch("[^\n]+") do
	-- 	table.insert(to_print, s)
	-- end

	vim.cmd("new")
	api.nvim_buf_set_text(0, 0, 0, 0, 0, buf_opts)
end, { noremap = true, silent = true })
--
-- setKey("n", "<leader><space>di", vim.inspect())
-- setKey("n", "<leader><space>di", function()
-- 	print(vim.inspect(vim.api.nvim_buf_get_name(0)))
-- 	-- print(vim.fn.expand("%:h"))
-- end)

-- setKey("n", "<C-a>", function()
-- 	print("has v.09?" .. vim.fn.has("nvim-0.9"))
-- 	print(vim.inspect(vim.opt.stc))
-- end)

-------------------------
-- => Function Keys
-------------------------
setKey("n", "<F12>", ":checkhealth<CR>")

-------------------------
-- => Files
-------------------------
setKey("n", "<Space>x", "<CMD>!chmod +x %<CR>")

-------------------------
-- =>  Insert Mode
-------------------------
setKey("i", "<C-s>", "<ESC>:w!<CR>a", silent) -- Save Current (in insert)

------------------------------
-- => Unmap
------------------------------
setKey("i", "<c-j>", "", noremap)
setKey("i", "<c-h>", "", noremap)
-- Formatting and View
setKey("n", "<C-.>", "")
setKey("i", "<Tab>", "<Tab>")
setKey("i", "<C-p>", "")
setKey("n", "<F1>", "")
setKey("v", "<F1>", "")
