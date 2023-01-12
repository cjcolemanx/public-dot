local M = {}

-- Setup
local setKey = vim.keymap.set
local cmd = vim.cmd

-- Opts
local silent = { silent = true }
local snr = { silent = true, noremap = true }

-- For Documenting
local legend = require("keymaps.documentation")

local add_simple = legend.add_simple_to_legend
local add_regular = legend.add_to_legend
local add_modal = legend.add_to_mode_dependent_to_legend

-------------------------
-- => Comment
-------------------------

--[[
Handles Comment Keybindings
--]]
function M.comment()
	local api = require("Comment.api")

	-- FIXME: Replace cursor at position
	setKey("i", "<C-_>", api.toggle.linewise.current)
	setKey("i", "<C-\\>", api.toggle.blockwise.current)

	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

	setKey("x", "gh", function()
		vim.api.nvim_feedkeys(esc, "nx", false)
		api.toggle.linewise(vim.fn.visualmode())
	end)
	setKey("x", "gb", function()
		vim.api.nvim_feedkeys(esc, "nx", false)
		api.toggle.blockwise(vim.fn.visualmode())
	end)

	local behavior = {
		toggler = {
			line = "gh",
			block = "gb",
		},
		opleader = {
			line = "gh",
			block = "gb",
		},
		extra = {
			above = "gk",
			below = "gj",
			eol = "gl",
		},
	}

	return behavior
end

-- DOCUMENT
add_simple("<C-_>", "Comment: Toggle Linewise Comment")
add_simple("<C-\\>", "Comment: Toggle Blockwise Comment")
add_regular("gh", "Comment: Toggle Linewise Comment", nil, nil, { "x" })
add_regular("gb", "Comment: Toggle Blockwise Comment", nil, nil, { "x" })

-------------------------
-- => LuaSnip
-------------------------

--[[
Handles LuaSnip keybindings.
--]]
function M.luasnip(ls)
	-- For Dynamic Snippets
	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		-- vim.keymap.set("i", "<Tab>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end)
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.choice_active() then
			ls.change_choice(-1)
		end
	end)

	-- Quickly Add A Blank Line (Can Navigate Through Snippet After)
	vim.keymap.set({ "i", "s" }, "<c-y>", "<esc>o", { silent = true })

	-- Quickly Edit The Current Buffer's Associated Snippets (Telescope picker)
	vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })

	-- Overrides regular popup closing, or just close luasnip popup
	vim.keymap.set("s", "<C-h>", "<cmd>lua choice_popup_close()<cr>", { silent = true, noremap = true })
end

-- DOCUMENT
add_regular("<C-j>", "Snippet: Scroll Snippet Option Down", nil, nil, { "i", "s" })
add_regular("<C-k>", "Snippet: Scroll Snippet Option Up", nil, nil, { "i", "s" })
add_regular("<C-h>", "Snippet: Jump backwards in snippet", nil, nil, { "i", "s" })
add_regular("<C-l>", "Snippet: Jump forwards in snippet", nil, nil, { "i", "s" })
add_regular("<C-y>", "Snippet: Insert Blankline Below", nil, nil, { "i", "s" })
add_regular("<Leader><CR>", "Snippet: Quick Edit", nil, { silent = true, noremap = true }, nil)
add_regular("<C-h>", "Snippet: Remove Choice Popup", nil, { silent = true, noremap = true }, { "s" })

-------------------------
-- => CMP
-------------------------

--[[
CMP mappings. 

Also handles Tabout, Telescope, and Luasnip Collisions
--]]
function M.cmp(cmp, luasnip)
	-- NOTE: Fixes CMP issues
	setKey("i", "<Tab>", "<Tab>")

	return {
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<M-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 3 }),
		["<down>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<M-k>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = -3 }),
		["<up>"] = cmp.mapping.select_prev_item(),

		-- Scroll Docs or do a tabout
		["<C-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.mapping.scroll_docs(-4)
			elseif
				not luasnip.expand_or_jumpable()
				and not luasnip.choice_active()
				and vim.bo.filetype ~= "TelescopePrompt"
			then
				vim.cmd("Tabout")
			-- elseif vim.bo.filetype == "TelescopePrompt" then
			else
				-- local key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
				-- vim.api.nvim_feedkeys(key, "i", false)
				return
			end
		end, { "i", "s" }),

		["<C-n>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.mapping.scroll_docs(4)
			elseif
				not luasnip.expand_or_jumpable()
				and not luasnip.choice_active()
				and vim.bo.filetype ~= "TelescopePrompt"
			then
				vim.cmd("TaboutBack")
			-- elseif vim.bo.filetype == "TelescopePrompt" then
			-- 	local key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
			-- 	vim.api.nvim_feedkeys(key, "i", false)
			else
				-- local key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
				-- vim.api.nvim_feedkeys(key, "i", false)
				return
			end
		end, { "i", "s" }),

		-- Complete Snipppet Or Insert Completion
		["<C-e>"] = cmp.mapping(function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				})
			end
		end, { "i", "s" }),

		["<C-l>"] = cmp.mapping(function()
			if vim.bo.filetype == "TelescopePrompt" then
				require("telescope.actions"):select_vertical()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Select, select = true })
			end
		end, { "i", "s" }),

		["<C-h>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),

		["<C-x>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),

		["<C-Space"] = cmp.mapping(function(fallback)
			cmp.get_entries()
		end, { "i", "s" }),
	}
end

add_regular("<C-j> || <Down>", "CMP: Select Next Item", nil, nil, { "i" })
add_regular("<C-k> || <Up>", "CMP: Select Previous Item", nil, nil, { "i" })
add_regular("<M-j>", "CMP: Select 3 Items Below", nil, nil, { "i" })
add_regular("<M-k>", "CMP: Select 3 Items Above", nil, nil, { "i" })
add_regular("<C-p>", "CMP: Scroll Doc Up", nil, nil, { "i", "s" })
add_regular("<C-n>", "CMP: Scroll Doc Down", nil, nil, { "i", "s" })
add_regular("<C-e> || <C-l>", "CMP: Confirm", nil, nil, { "i", "s" })
add_regular("<C-x>", "CMP: Abort", nil, nil, { "i", "s" })
add_regular("<C-Space>", "CMP: Get Entries", nil, nil, { "i", "s" })

-------------------------
-- => Telescope
-------------------------

--[[
Setup Telescope binds with `vim.keymap.set`.

builtin: -- telescope.builtins
utils: -- telescope.utils
previewers -- telescope.previewers
--]]
function M.telescope_binds(builtin, utils, previewers)
	require("plenary")
	-- Short
	setKey("n", ";e", function()
		builtin.diagnostics()
	end)
	setKey("n", ";f", function()
		builtin.find_files({
			no_ignore = false,
			hidden = true,
		})
	end)
	setKey("n", ";g", function()
		builtin.jumplist()
	end)
	setKey("n", ";h", function()
		builtin.help_tags()
	end)
	-- setKey("n", ";t", function()
	-- 	builtin.help_tags()
	-- end)
	setKey("n", ";u", function()
		builtin.oldfiles()
	end)
	setKey("n", ";;", function()
		builtin.resume()
	end)
	setKey("n", "\\\\", function()
		builtin.buffers()
	end)

	-- Verbose
	setKey("n", ";cmd", function()
		builtin.commands()
	end)
	setKey("n", ";grep", function()
		builtin.live_grep()
	end)
	setKey("n", ";keys", function()
		builtin.keymaps()
	end)
	setKey("n", ";man", function()
		builtin.man_pages()
	end)
	setKey("n", ";opt", function()
		builtin.vim_options()
	end)
	setKey("n", ";reg", function()
		builtin.registers()
	end)
	setKey("n", ";col", function()
		builtin.colorscheme()
	end)

	-- Chorded
	setKey("n", ";<space>da", function()
		builtin.symbols({ sources = { "emoji", "kaomoji", "gitmoji", "nerd", "math", "latex" } })
	end)
	setKey("n", ";<space>de", function()
		builtin.symbols({ sources = { "emoji", "gitmoji" } })
	end)
	setKey("n", ";<space>dn", function()
		builtin.symbols({ sources = { "kaomoji", "nerd", "gitmoji" } })
	end)
	setKey("n", ";<space>dk", function()
		builtin.symbols({ sources = { "kaomoji" } })
	end)
	setKey("n", ";<space>r", function()
		builtin.reloader()
	end)
	setKey("n", ";<space>lg", function()
		builtin.git_branches()
	end)
	setKey("n", ";<space>la", function()
		builtin.git_commits()
	end)
	setKey("n", ";<space>ha", function()
		builtin.highlights({
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<C-y>", function()
					local selected = require("telescope.actions.state").get_selected_entry()
					vim.cmd({ cmd = "echo", args = { selected[1] } })
					require("telescope.actions").close(prompt_bufnr)
				end)

				return true
			end,
		})
	end)

	-- Custom

	-- Extensions
	setKey("n", ";todo", ":TodoTelescope <CR>")
	-- setKey("n", ";s", ":Telescope project <CR>")
end

--[[
Setup default mappings (used when Telescope is open)

actions: -- telescope.actions
--]]
function M.telescope_setup_mappings(actions)
	-- TODO: Document Keybinds
	return {
		defaults = {
			mappings = {
				n = {
					["q"] = actions.close,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
				},
				i = {
					["<esc>"] = actions.close,
					["<c-j>"] = actions.move_selection_next,
					["<c-k>"] = actions.move_selection_previous,
					["<c-o>"] = actions.select_tab,
				},
			},
		},
		pickers = {
			help_tags = {
				mappings = {
					n = {
						["q"] = actions.close,
						["<C-Space>"] = actions.select_vertical,
						["<leader><Space>"] = actions.select_vertical,
						["<c-o>"] = actions.select_tab,
					},
				},
			},
			man_pages = {
				mappings = {
					n = {
						["<C-Space>"] = actions.select_vertical,
						["<leader><Space>"] = actions.select_vertical,
						["<C-o>"] = actions.select_tab,
					},
				},
			},
		},
		extensions = {
			file_browser = {
				mappings = {
					["i"] = {
						["<C-w>"] = function()
							vim.cmd("normal vbd")
						end,
					},
					["n"] = {
						["i"] = function()
							vim.cmd("startinsert")
						end,
						["/"] = function()
							vim.cmd("startinsert")
						end,
					},
				},
			},
		},
	}
end

add_simple("q", "TelescopePrompt: Close")
add_simple(";todo", "Telescope: TodoTelescope")
add_simple(";<Space>da", "Telescope: Emojis (All)")
add_simple(";<Space>de", "Telescope: Emojis (Emoji)")
add_simple(";<Space>dn", "Telescope: Emojis (NerdFont)")
add_simple(";<Space>dk", "Telescope: Emojis (Kaomoji)")
add_simple(";<Space>r", "Telescope: Reload Plugins")
add_simple(";<Space>lg", "Telescope: Git Branches")
add_simple(";<Space>la", "Telescope: Git Commits")
add_simple(";<Space>ha", "Telescope: Highlight Groups")
add_simple(";e", "Telescope: Diagnostics")
add_simple(";f", "Telescope: Find Files")
add_simple(";g", "Telescope: Jump List")
add_simple(";h", "Telescope: Help Tags")
add_simple(";y", "Telescope: Recent Files")
add_simple(";u", "Telescope: Resume Cached Picker")
add_simple(";;", "Telescope: Buffers")
add_simple("\\\\", "Telescope: Diagnostics")
add_simple(";cmd", "Telescope: Commands")
add_simple(";grep", "Telescope: Live Grep")
add_simple(";keys", "Telescope: Keymaps")
add_simple(";man", "Telescope: Man Pages")
add_simple(";opt", "Telescope: Set Vim Options")
add_simple(";reg", "Telescope: Registers")
add_simple(";col", "Telescope: Change Colorscheme")

-------------------------
-- => LSP & LSPSaga
-------------------------

--[[
-- NOTE: Utilized in `nvim-lsp.rc.lua`

Keymaps to get added on attachment to buffer.

bmap: -- buffer-map function
bnmap: -- buffer-map function ("normal" mode only)
buf_set_keymap: -- sets keymap for a certain buffer
--]]
function M.lsp_maps_on_attach(bmap, bnmap, buf_set_keymap, opts)
	-- Insert Mode
	setKey("i", "<C-m>", "<cmd>Lspsaga peek_definition<CR>", opts)
	-- setKey("i", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	-- Normal Mode
	buf_set_keymap("n", ";1", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	buf_set_keymap("n", ";2", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	buf_set_keymap("n", ";3", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	-- buf_set_keymap("n", ";k", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

	-- LSP Saga
	-- bnmap("gd", "<Cmd>Lspsaga lsp_finder<CR>")
	bnmap(";d", "<Cmd>Lspsaga peek_definition<CR>")
	bnmap(";k", "<Cmd>Lspsaga hover_doc<CR>")
	bnmap(";t", "<cmd>Lspsaga outline<CR>")
	bnmap(";r", "<cmd>Lspsaga rename<CR>")
	bnmap(";a", "<cmd>Lspsaga code_action<CR>")
	bnmap(";go", "<cmd>Lspsaga show_line_diagnostics<CR>")
	bnmap(";gn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	bnmap(";gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

	-- NOTE: Terminal is yucky
	-- setKey("n", "<M-CR>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
	-- setKey("t", "<ESC>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
	-- setKey("t", "<M-CR>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

add_regular("<C-m>", "LSP: Peek/Edit Definition", nil, nil, { "i" })
add_simple(";1", "LSP: Peek Definition")
add_simple(";2", "LSP: Peek Declaration")
add_simple(";3", "LSP: Peek Implementation")
add_simple(";p", "LSP: Peek Definition")
add_simple(";k", "LSP: Show Hoverdoc")
add_simple(";t", "LSP: Toggle LSP Outline")
add_simple(";r", "LSP: Rename")
add_simple(";a", "LSP: Code Action")
add_simple(";go", "LSP: Show Line Diagnostic")
add_simple(";gn", "LSP: Next Diagnostic")
add_simple(";gp", "LSP: Previous Diagnostic")

-------------------------
-- => Ufo
-------------------------

function M.ufo_binds()
	local ufo = require("ufo")
	vim.keymap.set("n", "zR", ufo.openAllFolds)
	vim.keymap.set("n", "zM", ufo.closeAllFolds)
	vim.keymap.set("n", "zl", ufo.goNextClosedFold)
	vim.keymap.set("n", "zh", ufo.goPreviousClosedFold)
	vim.keymap.set("n", ";z", ufo.peekFoldedLinesUnderCursor)
end

add_simple("zR", "Fold: Open All Folds")
add_simple("zM", "Fold: Close All Folds")
add_simple("zl", "Fold: Go To Next Closed Fold")
add_simple("zh", "Fold: Go To Previous Closed Fold")
add_simple(";z", "Fold: Peek Fold Under Cursor")

-------------------------
-- => NvimTree
-------------------------

function M.nvimTree_binds()
	setKey({ "n", "x" }, "<C-b>", ":NvimTreeToggle<CR>", silent)
	setKey({ "n", "x" }, "<leader>b", ":NvimTreeFocus<CR>", silent)
end

--[[
Set up NvimTree Keybinds (in config)

helpers: -- module of helper functions (user-defined)
--]]
function M.nvimTree(helpers)
	local nt = require("nvim-tree.api")
	return {
		list = {
			{
				key = "<C-o>",
				action = "cd",
				action_cb = function()
					nt.tree.change_root_to_node()
					vim.api.nvim_feedkeys("ggj", "nx", false)
				end,
			},
			{ key = { "<leader>t", "T" }, action = "tabnew" },
			-- Custom
			{ key = "s", action = "vsplit", action_cb = helpers.split_right },
			{ key = "o", action = "edit" },
			{ key = "L", action = "vsplit", action_cb = helpers.split_right_and_refocus },
			{ key = "l", action = "open folder", action_cb = helpers.expand_folder },
			{ key = ">", action = "split", action_cb = helpers.split_below_and_refocus },
			{ key = "ga", action = "git_add", action_cb = helpers.git_add },
			-- FIXME: Isn't this redundant?
			-- { key = "gr", action = "git_add", action_cb = helpers.git_add },
			{ key = "<C-f>", action = "preview file", action_cb = helpers.launch_find_files },
			{ key = "<C-g>", action = "live grep", action_cb = helpers.launch_live_grep },
			-- { key = "<C-p>", action = "open context menu", action_cb = helpers.tree_actions_menu },
			{ key = "<C-c>", action = "change global cwd", action_cb = helpers.change_root_to_global_cwd },
			{ key = ";f", cb = helpers.launch_find_files },
			{ key = ";g", cb = helpers.launch_live_grep },
			-- API
			{ key = "<leader>r", action_cb = nt.tree.reload },
			{ key = "<leader>g", cb = nt.tree.toggle_gitignore_filter },
			{ key = "?", cb = nt.node.show_info_popup },
			{ key = { "<ESC>", "q" }, cb = nt.tree.close },
			{ key = "<leader>ms", cb = nt.marks.select },
			{ key = "gmj", cb = nt.marks.navigate.next },
			{ key = "gmk", cb = nt.marks.navigate.prev },
			{ key = "gml", cb = nt.marks.navigate.next },
			{ key = "gmh", cb = nt.marks.navigate.prev },
		},
	}
end

add_regular("<C-b>", "Files: Toggle Sidebar", nil, nil, { "n", "x" })
add_regular("<Leader>b", "Files: Focus Sidebar", nil, nil, { "n", "x" })
add_simple("<C-o>", "Files: Change Root")
add_simple("<Leader>t", "Files: Open File In New Tab")
add_simple("s", "Files: Split Vertically and Focus")
add_simple("L", "Files: Split Vertically, Don't Focus")
add_simple(">", "Files: Split Horizontally, Don't Focus")
add_simple("ga", "Files: Git Add")
-- add_simple("gr", "Files: Git Add")
add_simple("<C-f>", "Files: Preview File")
add_simple("<C-g>", "Files: Live Grep")
add_simple("<C-c>", "Files: Change Global Working Directory")
add_simple(";f", "Files: Find Files")
add_simple(";g", "Files: Grep Files")
add_simple("<Leader>r", "Files: Refresh Tree View")
add_simple("<Leader>g", "Files: Toggle .gitignore Filter")
add_simple("?", "Files: Show File Hover-info Popup")
add_simple("<Esc> || q", "Files: Close")
add_simple("<Leader>ms", "Files: Create Mark")
add_simple("gmj || gml", "Files: Go to Next Mark")
add_simple("gmk || gmh", "Files: Go to Previous Mark")

-------------------------
-- => Trouble
-------------------------

function M.trouble_binds()
	setKey("n", "<leader>1", "<cmd>TroubleToggle<cr>", snr)
end

add_simple("<Leader>1", "Diagnostics: Toggle Diagnostics Window")

-------------------------
-- => Zen Mode
-------------------------

function M.zenMode_binds()
	setKey("n", "<leader>z", ":ZenMode<CR>")
end

add_simple("<Leader>z", "View: Toggle Zen Mode")

-------------------------
-- => High-Str
-------------------------

function M.high_str_binds()
	setKey("v", "<C-h>1", ":<c-u>HSHighlight 1<CR>", snr)
	setKey("v", "<C-h>2", ":<c-u>HSHighlight 2<CR>", snr)
	setKey("v", "<C-h>3", ":<c-u>HSHighlight 3<CR>", snr)
	setKey("v", "<C-h>4", ":<c-u>HSHighlight 4<CR>", snr)
	setKey("v", "<C-h>5", ":<c-u>HSHighlight 5<CR>", snr)
	setKey("v", "<C-h>6", ":<c-u>HSHighlight 6<CR>", snr)
	setKey("v", "<C-h>7", ":<c-u>HSHighlight 7<CR>", snr)
	setKey("v", "<C-h>8", ":<c-u>HSHighlight 8<CR>", snr)
	setKey("v", "<C-h>9", ":<c-u>HSHighlight 9<CR>", snr)
	setKey("v", "<C-h><C-h>", ":<c-u>HSRmHighlight<CR>", snr)
end

add_regular("<C-h>{number}", "Highlighter: Highlight Selection With Highlight {number}", nil, nil, { "v" })
add_regular("<C-h><C-h>", "Highlighter: Remove Highlight From Selection", nil, nil, { "v" })

-------------------------
-- => Tabby
-------------------------

function M.tabby()
	setKey("n", "<leader><leader>rt", ":TabRename ")
end

add_simple("<Leader><Leader>rt", "Tabs: Rename Tab")

-------------------------
-- => Mind.nvim
-------------------------

function M.mind(mind)
	local k = mind.keymap
	local n = mind.node
	vim.g.mind_nvim_main_open = false
	vim.g.mind_nvim_project_open = false

	-- Open Mind (main)
	setKey("n", "<leader>mg", function()
		local mind_open = vim.g.mind_nvim_main_open

		if not mind_open or mind_open == nil then
			mind.open_main()
			vim.g.mind_nvim_main_open = true
		else
			mind.close()
			vim.g.mind_nvim_main_open = false
		end
		-- print(inspect(api.nvim_buf_get_number(0)))
	end, snr)

	-- Open Mind (project)
	setKey("n", "<leader>ml", function()
		local mind_open = vim.g.mind_nvim_project_open

		if not mind_open or mind_open == nil then
			mind.open_project()
			vim.g.mind_nvim_project_open = true
		else
			mind.close()
			vim.g.mind_nvim_project_open = false
		end
	end, snr)

	-- TODO: Add Mind to project
	setKey("n", "<leader>ma", function() end, snr)
end

add_simple("<Leader>mg", "Mind: Toggle Main Mind Window")
add_simple("<Leader>ml", "Mind: Toggle Project Mind Window")
add_simple("<Leader>ma", "Mind: Add Mind to a Project (WIP)")

-------------------------
-- => Tabout
-------------------------

--[[
Tabout mappings. 

Also handles CMP Collisions
--]]
function M.tabout()
	local function replace_keycodes(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local function tabout_binding()
		if vim.fn.pumvisible() ~= 0 then
			return replace_keycodes("<C-p>")
		else
			return replace_keycodes("<Plug>(Tabout)")
		end
	end

	local function backwards_tabout_binding()
		if vim.fn.pumvisible() ~= 0 then
			return replace_keycodes("<C-n>")
		else
			return replace_keycodes("<Plug>(TaboutBack)")
		end
	end

	setKey("i", "<C-p>", tabout_binding, { expr = true })
	setKey("i", "<C-n>", backwards_tabout_binding, { expr = true })
end

add_simple("<C-p>", "Tabout: Forward Out of Characters")
add_simple("<C-n>", "Tabout: Backward Out of Characters")

-------------------------
-- => Leap
-------------------------

function M.leap()
	-- Bidirectional
	setKey({ "n", "v" }, "<Space>l", function()
		require("leap").leap({ target_windows = { vim.fn.win_getid() } })
	end, silent)
	-- Across Windows
	setKey({ "n", "v" }, "<Space>L", function()
		require("leap").leap({
			target_windows = vim.tbl_filter(function(win)
				return vim.api.nvim_win_get_config(win).focusable
			end, vim.api.nvim_tabpage_list_wins(0)),
		})
	end, silent)
end

add_regular("<Space>l", "Leap: Bidirectional (single file)", nil, nil, { "n", "v" })
add_regular("<Space>L", "Leap: Across Windows", nil, nil, { "n", "v" })

-------------------------
-- => Surround
-------------------------

function M.surround()
	return {
		normal = "s",
		normal_line = "S",
		normal_cur = "<Leader>s",
		normal_cur_line = "<Leader>S",
		insert = "<C-Space><C-s>",
		insert_line = "<C-Space><C-l>",
		visual = "s",
		visual_line = "S",
		delete = "ds",
		change = "cs",
	}
end

add_simple("s", "Surround: Surround{motion}{character}")
add_simple("S", "Surround: Surround, like '(\n word \n)'")
add_simple("<Leader>s", "Surround: Surround Line With {character}")
add_simple("<Leader>S", "Surround: Surround Line,like '(\n word \n)'")
add_simple("ds", "Surround: Remove Surround matching {character}")
add_simple("cs", "Surround: Change Surround{target_char}{replacement_char}")
add_regular("s", "Surround: Surround{character}", nil, nil, { "v" })
add_regular("S", "Surround: SurroundVisual, like '(\n words \n)", nil, nil, { "v" })

M.legend = legend.legend

return M
