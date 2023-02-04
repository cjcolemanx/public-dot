local M = {}

-- Setup
local setKey = vim.keymap.set
local cmd = vim.cmd

-- Opts
local silent = { silent = true }
local snr = { silent = true, noremap = true }
local sne = { silent = true, expr = false }
local noremap = { noremap = true }

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

		-- ["<C-Space"] = cmp.mapping(function(fallback)
		-- 	cmp.get_entries()
		-- end, { "i", "s" }),
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
	setKey("n", ";e", builtin.diagnostics)
	setKey("n", ";f", function()
		builtin.find_files({
			no_ignore = false,
			hidden = true,
		})
	end)
	setKey("n", ";j", builtin.jumplist)
	setKey("n", ";h", builtin.help_tags)
	-- setKey("n", ";u", builtin.oldfiles)
	setKey("n", ";u", "<CMD>Telescope undo<CR>")
	setKey("n", ";;", builtin.resume)
	setKey("n", "\\\\", builtin.buffers)

	-- Search For Things
	setKey("n", ";sf", builtin.find_files)
	setKey("n", ";sb", builtin.buffers)
	setKey("n", ";sm", builtin.marks)
	setKey("n", ";sr", builtin.registers)
	setKey("n", ";sw", builtin.grep_string)
	setKey("n", ";s/", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end)

	-- Verbose
	setKey("n", ";cmd", builtin.commands)
	setKey("n", ";grep", builtin.live_grep)
	setKey("n", ";keys", builtin.keymaps)
	setKey("n", ";man", builtin.man_pages)
	setKey("n", ";opt", builtin.vim_options)
	setKey("n", ";col", builtin.colorscheme)

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
	setKey("n", ";<space>r", builtin.reloader)
	setKey("n", ";<space>lg", builtin.git_branches)
	setKey("n", ";<space>la", builtin.git_commits)
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

	-- Extensions
	setKey("n", "<Leader>;todo", ":TodoTelescope <CR>")
	setKey("n", "<Leader>;m", require("telescope").extensions.media_files.media_files)
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
add_simple("<Leader>;todo", "Telescope: TodoTelescope")
add_simple(";<Space>da", "Telescope: Emojis (All)")
add_simple(";<Space>de", "Telescope: Emojis (Emoji)")
add_simple(";<Space>dn", "Telescope: Emojis (NerdFont)")
add_simple(";<Space>dk", "Telescope: Emojis (Kaomoji)")
add_simple(";<Space>r", "Telescope: Reload Plugins")
add_simple(";<Space>lg", "Telescope: Git Branches")
add_simple(";<Space>la", "Telescope: Git Commits")
add_simple(";<Space>ha", "Telescope: Highlight Groups")
add_simple(";e", "Telescope: Diagnostics")
add_simple(";f", "Telescope: Find [F]iles")
add_simple(";j", "Telescope: [J]ump List")
add_simple(";h", "Telescope: [H]elp Tags")
add_simple(";y", "Telescope: Recent Files")
add_simple(";u", "Telescope: Telescope [U]ndo History")
add_simple(";;", "Telescope: Buffers")
add_simple(";sf", "Telescope: [S]earch [F]iles (Exclude Hidden)")
add_simple(";sb", "Telescope: [S]earch [B]uffers")
add_simple(";sb", "Telescope: [S]earch [M]arks")
add_simple(";sw", "Telescope: [S]earch [f]or String")
add_simple(";s/", "Telescope: [S]earch [C]urrent Buffer")
add_simple(";st", "Telescope: [S]earch [R]egisters")
add_simple("\\\\", "Telescope: Diagnostics")
add_simple(";cmd", "Telescope: Commands")
add_simple(";grep", "Telescope: Live Grep")
add_simple(";keys", "Telescope: Keymaps")
add_simple(";man", "Telescope: Man Pages")
add_simple(";opt", "Telescope: Set Vim Options")
add_simple(";col", "Telescope: Change Colorscheme")

-------------------------
-- => LSP & LSPSaga
-------------------------

--[[
Keymaps to get added on attachment to buffer.

bmap: -- buffer-map function
bnmap: -- buffer-map function ("normal" mode only)
buf_set_keymap: -- sets keymap for a certain buffer
--]]
function M.lsp_maps_on_attach(bmap, bnmap, buf_set_keymap, opts)
	-- Insert Mode
	setKey("i", "<C-m>", "<cmd>Lspsaga peek_definition<CR>", opts)
	-- setKey("i", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	-- Built-in
	bmap("n", "gd", vim.lsp.buf.definition)
	bmap("n", "gr", "<CMD>Telescope lsp_references<CR>")
	bmap("n", "gI", vim.lsp.buf.implementation)
	bmap("n", "gt", vim.lsp.buf.type_definition)
	bmap("n", "<Leader>ds", "<CMD>Telescope lsp_document_symbols<CR>")
	bmap("n", "<Leader>ws", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>")

	-- Allow dictionary (from null_ls) in markdown
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "org", "text", "markdown" },
		callback = function()
			bmap("n", ";k", vim.lsp.buf.hover)
		end,
	})

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

add_simple("gd", "LSP: Go to Definition")
add_simple("gr", "LSP: Go to references")
add_simple("gI", "LSP: Go to Implementation")
add_simple("gt", "LSP: Go to Type Definition")
add_simple("<Leader>ds", "LSP: Telescope Document Symbols")
add_simple("<Leader>ws", "LSP: Telescope Workspace Symbols")
add_regular("<C-m>", "LSP: Peek/Edit Definition", nil, nil, { "i" })
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
	-- setKey("n", "<leader>1", "<cmd>TroubleToggle<cr>", snr)
	setKey("n", "<Space>1", "<cmd>TroubleToggle<cr>", snr)
end

-- add_simple("<Leader>1", "Diagnostics: Toggle Diagnostics Window")
add_simple("<Space>1", "Diagnostics: Toggle Diagnostics Window")

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
	-- Custom Agenda Use Case
	vim.g.mind_nvim_agenda_open = false
	vim.g.mind_nvim_agenda_open = false
	vim.g.mind_nvim_temporal_open = false

	-- Open Mind (main)
	setKey("n", "<leader>mg", function()
		local mind_open = vim.g.mind_nvim_main_open

		if not mind_open or mind_open == nil then
			mind.open_main()
			vim.g.mind_nvim_main_open = true
			vim.g.mind_nvim_project_open = false
			vim.g.mind_nvim_agenda_open = false
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
			vim.g.mind_nvim_main_open = false
			vim.g.mind_nvim_agenda_open = false
		else
			mind.close()
			vim.g.mind_nvim_project_open = false
		end
	end, snr)

	setKey("n", "<leader>mo", function()
		local mind_open = vim.g.mind_nvim_agenda_open

		if not mind_open or mind_open == nil then
			-- FIXME: There's probably a better way to do this...
			-- NOTE: There's probably not : )
			vim.g.mind_nvim_agenda_pre_cwd = vim.fn.getcwd()

			-- Switch directories to agenda...
			vim.fn.chdir(vim.g.my_agenda_dir)
			mind.open_project()

			vim.g.mind_nvim_main_open = false
			vim.g.mind_nvim_project_open = false
			vim.g.mind_nvim_agenda_open = true
		else
			mind.close()
			vim.fn.chdir(vim.g.mind_nvim_agenda_pre_cwd)
			vim.g.mind_nvim_agenda_open = false
		end
	end, snr)

	setKey("n", "<leader>mn", function()
		local mind_open = vim.g.mind_nvim_temporal_open

		if not mind_open or mind_open == nil then
			-- FIXME: There's probably a better way to do this...
			-- NOTE: There's probably not : )
			-- Switch directories to temporal notes...
			vim.fn.chdir(vim.g.my_temporal_notes_dir)
			mind.open_project()

			vim.g.mind_nvim_main_open = false
			vim.g.mind_nvim_project_open = false
			vim.g.mind_nvim_agenda_open = false
			vim.g.mind_nvim_temporal_open = true
		else
			mind.close()
			vim.g.mind_nvim_temporal_open = false
		end
	end, snr)

	setKey("n", "<leader>ma", "<CMD>MindOpenSmartProject<CR>", snr)
	setKey("n", "<leader>mq", "<CMD>MindOpenProject<CR>", snr)
end

M.MindMaps = {
	normal = {
		["<cr>"] = "open_data",
		["<s-cr>"] = "open_data_index",
		l = "toggle_node",
		h = "toggle_node",
		["<s-tab>"] = "toggle_node",
		["/"] = "select_path",
		["$"] = "change_icon_menu",
		-- c = "add_inside_end_index",
		A = "add_inside_start",
		a = "add_inside_end",
		c = "copy_node_link",
		C = "copy_node_link_index",
		d = "delete",
		D = "delete_file",
		p = "add_above",
		n = "add_below",
		q = "quit",
		r = "rename",
		R = "change_icon",
		u = "make_url",
		x = "select",
	},
	selection = {
		["<cr>"] = "open_data",
		["<s-tab>"] = "toggle_node",
		["/"] = "select_path",
		I = "move_inside_start",
		i = "move_inside_end",
		p = "move_above",
		n = "move_below",
		-- ["<C-k>"] = "move_above",
		-- ["<C-j>"] = "move_below",
		q = "quit",
		x = "select",
	},
}

add_simple("<CR>", "Mind: Open Mind File Under Cursor")
add_simple("<Shift-CR>", "Mind: Open Mind Date Index")
add_simple("l || h", "Mind: Toggle Node")
add_simple("<Shift-Tab>", "Mind: Toggle Node")
add_simple("/", "Mind: Select Path")
add_simple("$", "Mind: Open 'Change Icon' menu")
add_simple("a", "Mind: Add Node Inside (bottom)")
add_simple("A", "Mind: Add Node Inside (top)")
add_simple("c", "Mind: Copy Node Link")
add_simple("C", "Mind: Copy Node Link Index")
add_simple("d", "Mind: Delete Node")
add_simple("D", "Mind: Delete File")
add_simple("p", "Mind: Add Node Above")
add_simple("n", "Mind: Add Node Below")
add_simple("q", "Mind: Quit Mind")
add_simple("r", "Mind: Rename Node")
add_simple("R", "Mind: Change Node Icon")
add_simple("u", "Mind: Make URL")
add_simple("x", "Mind: Select Node")
add_simple("/", "Mind: Select Node Path")
add_simple("I", "Mind: Insert Node Selected At Top")
add_simple("i", "Mind: Insert Node Selected At Bottom")
-- add_simple("<C-k>", "Mind: Move Selected Node Above")
-- add_simple("<C-j>", "Mind: Move Selected Node Below")
add_simple("p", "Mind: Move Selected Node Above")
add_simple("n", "Mind: Move Selected Node Below")
add_simple("q", "Mind: Quit Mind")
add_simple("x", "Mind: Select Node")
add_simple("<CR>", "Mind: Open Selected Node's data")
add_simple("<Shift-Tab>", "Mind: Toggle Selected Node")
add_simple("<Leader>mg", "Mind: Toggle Main Mind Window")
add_simple("<Leader>ml", "Mind: Toggle Project Mind Window")
add_simple("<Leader>ma", "Mind: Add Mind to a Project")
add_simple("<Leader>mo", "Mind: Open 'Org-Mode' (Agenda, set with vim.g.my_agenda_dir)")
add_simple("<Leader>mn", "Mind: Open Temporal Notes")

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

-------------------------
-- => Todo Comments
-------------------------

function M.todo(td)
	setKey("n", "]]", function()
		td.jump_next()
	end)
	setKey("n", "[[", function()
		td.jump_prev()
	end)
	setKey("n", "]t", function()
		td.jump_next({ keywords = { "TODO" } })
	end)
	setKey("n", "[t", function()
		td.jump_prev({ keywords = { "TODO" } })
	end)
	setKey("n", "]e", function()
		td.jump_next({ keywords = { "FIXME" } })
	end)
	setKey("n", "[e", function()
		td.jump_prev({ keywords = { "FIXME" } })
	end)
	setKey("n", "]n", function()
		td.jump_next({ keywords = { "NOTE" } })
	end)
	setKey("n", "[n", function()
		td.jump_prev({ keywords = { "NOTE" } })
	end)
end

-------------------------
-- => No-Neck-Pain
-------------------------
-- function M.noNeckPain()
-- 	setKey("n", "<Leader>a", "<CMD>NoNeckPain<CR>", silent)
-- end
--
-- add_simple("<Leader>a", "NoNeckPain: Center Current Window")

-------------------------
-- => Refactoring.Nvim
-------------------------
function M.refactoring(refactoring)
	local opts = { silent = true, noremap = true, expr = false }
	local rf = refactoring.refactor
	local db = refactoring.debug

	-- Visual
	setKey("v", "<Leader>re", function()
		rf("Extract Function")
	end, opts)
	setKey("v", "<Leader>rf", function()
		rf("Extract Function To File")
	end, opts)
	setKey("v", "<Leader>rv", function()
		rf("Extract Variable")
	end, opts)

	-- Inline works in visual and normal
	setKey({ "n", "v" }, "<Leader>ri", function()
		rf("Inline Variable")
	end, opts)

	-- Block
	setKey("n", "<Leader>rb", function()
		rf("Extract Block")
	end, opts)
	setKey("n", "<Leader>rbf", function()
		rf("Extract Block To File")
	end, opts)

	-- Telescope
	setKey("v", "<Leader>rr", function()
		require("telescope").extensions.refactoring.refactors()
	end, noremap)

	--
	-- Debugging
	--

	-- Mark the calling function
	setKey({ "v", "n" }, "<Leader>rdj", function()
		db.printf({ below = true })
	end, noremap)
	setKey({ "v", "n" }, "<Leader>rdk", function()
		db.printf({ below = false })
	end, noremap)

	-- mark Variables
	setKey("n", "<Leader>rdv", function()
		db.print_var({ normal = true })
	end, noremap)
	setKey("v", "<Leader>rdv", function()
		db.print_var()
	end, noremap)

	-- Clean Debug Print Statements
	setKey("n", "<Leader>rdclear", function()
		db.cleanup()
	end, noremap)
end

add_regular("<Leader>re", "Refactoring: Extract Function", nil, nil, { "v" })
add_regular("<Leader>rf", "Refactoring: Extract Function to File", nil, nil, { "v" })
add_regular("<Leader>rv", "Refactoring: Extract Variable", nil, nil, { "v" })
add_regular("<Leader>ri", "Refactoring: Inline Variable", nil, nil, { "n", "v" })
add_regular("<Leader>rr", "Refactoring: Telescope Refactor Options", nil, nil, { "v" })
add_simple("<Leader>rb", "Refactoring: Extract Block")
add_simple("<Leader>rbi", "Refactoring: Extract Block to File")
add_simple("<Leader>rdv", "Refactoring (Debug): Add Debug Print for Variable Under Cursor")
add_simple("<Leader>rdclear", "Refactoring (Debug): Remove Print Statuements Generated by Refactoring Plugin")
add_regular("<Leader>rdv", "Refactoring (Debug): Add Debug Print for Visually Selected Variable", nil, nil, { "v" })
add_regular(
	"<Leader>rdj",
	"Refactoring (Debug): Add Debug for Function Call Below Current Position",
	nil,
	nil,
	{ "n", "v" }
)
add_regular(
	"<Leader>rdk",
	"Refactoring (Debug): Add Debug for Function Call Above Current Position",
	nil,
	nil,
	{ "n", "v" }
)

-------------------------
-- => Dashboard
-------------------------
function M.dashboard()
	setKey("n", ";;da", function()
		vim.cmd("Dashboard")
		-- require("dashboard"):instance(true)
	end, silent)
end

add_simple(";;da", "Dashboard: Go to Dashboard")

-------------------------
-- => Treesitter
-------------------------
function M.treeSitter()
	setKey("n", "<leader>hh", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })
	return {
		incremental_selection = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
		textobjects = {
			select = {
				["of"] = "@function.outer",
				["if"] = "@function.inner",
				["oc"] = "@class.outer",
				["ic"] = "@class.inner",
				["ob"] = "@block.outer",
				["ib"] = "@block.inner",
				["ol"] = "@call.outer",
				["il"] = "@call.inner",
				["op"] = "@parameter.outer",
				["ip"] = "@parameter.inner",
				["oo"] = "@condition.outer",
				["io"] = "@condition.inner",
				["os"] = "@statement.outer",
				["is"] = "@statement.inner",
			},
			move = {
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@c.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]M"] = "@c.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@c.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[M"] = "@c.outer",
				},
			},
		},
		swap = {
			next = {
				["<Leader>a"] = "@parameter.inner",
			},
			previous = {
				["<Leader>A"] = "@parameter.inner",
			},
		},
	}
end

-------------------------
-- => Harpoon
-------------------------
function M.harpoonMarks(mark, ui)
	setKey("n", "<Space>ha", mark.add_file)
	setKey("n", "<Space>ho", "<CMD>Telescope harpoon marks<CR>")
	setKey("n", "<Space>hp", "<CMD>lua require('harpoon.ui').nav_next()<CR>")
	setKey("n", "<Space>hn", "<CMD>lua require('harpoon.ui').nav_prev()<CR>")
	setKey("n", "<Space>h1", "<CMD>lua require('harpoon.ui').nav_file(1)<CR>")
	setKey("n", "<Space>h2", "<CMD>lua require('harpoon.ui').nav_file(2)<CR>")
	setKey("n", "<Space>h3", "<CMD>lua require('harpoon.ui').nav_file(3)<CR>")
	setKey("n", "<Space>h4", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>")
end

add_simple("<Space>ha", "Harpoon: [H]arpoon [A]dd Mark")
add_simple("<Space>ho", "Harpoon: [H]arpoon [O]pen Ui")
add_simple("<Space>h{p/n}", "Harpoon: [H]arpoon Next (p) or Previous (n)")
add_simple("<Space>h{1,2,3,4}", "Harpoon: [H]arpoon #")

-------------------------
-- => Undotree
-------------------------
function M.undoTree()
	setKey("n", "<M-u>", "<CMD>UndotreeToggle<CR>")
end

add_simple("Alt-u", "UndoTree: Toggle UndoTree")

-------------------------
-- => Vim Fugitive
-------------------------
function M.fugitive()
	setKey("n", "<Leader>gs", "<CMD>Git<CR>")
end

add_simple("<Leader>gs", "Fugitive: Open [G]it [S]tatus in Fugitive")

-------------------------
-- => Glow
-------------------------
function M.glow()
	vim.api.nvim_create_augroup("GlowAutocommands", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = "GlowAutocommands",
		pattern = "markdown",
		callback = function()
			setKey("n", ";sp", "<CMD>Glow<CR>")
		end,
	})
end

add_simple(";sp", "Markdown: [s]how Glow [p]review")

-------------------------
-- => Null LS
-------------------------
function M.null_ls(toggle)
	setKey("n", "<leader>df", function()
		toggle()
	end)
end

add_simple("<Leader>", "Formatting: [d]isable [f]ormatters (buflocal)")

-------------------------
-- => NeoTest
-------------------------
function M.neotest(nt)
	-- Run Nearest
	setKey("n", "<Space>tr", function()
		nt.run.run()
	end)
	-- Debug the Nearest Test
	setKey("n", "<Space>td", function()
		nt.run.run({ strategy = "dap" })
	end)
	-- Run All Tests in current file
	setKey("n", "<Space>te", function()
		nt.run.run(vim.fn.expand("%"))
	end)
	-- Stop nearest test
	setKey("n", "<Space>tq", function()
		nt.run.stop()
	end)
	-- Attach nearest test
	setKey("n", "<Space>ta", function()
		nt.run.attach()
	end)

	setKey("n", "<Space>3", nt.output_panel.toggle)
end

add_simple("<Space>tr", "Neotest: Run Nearest Test")
add_simple("<Space>td", "Neotest: Debug Nearest Test")
add_simple("<Space>te", "Neotest: Run [e]very Test in the Current File")
add_simple("<Space>ta", "Neotest: [a]ttach to Nearest Test")
add_simple("<Space>tq", "Neotest: [q]uit (Stop) the Nearest Test")
add_simple("<Space>3", "Neotest: Toggle Test Output panel")

-------------------------
-- => Dap
-------------------------
function M.dap(d, ui)
	setKey("n", "<F2>", d.step_over)
	setKey("n", "<F3>", d.step_into)
	setKey("n", "<F4>", d.step_out)
	setKey("n", "<F5>", d.continue)

	setKey("n", ";DT", d.toggle_breakpoint)

	-- setKey("n", ";D?", require("dap.ui.variables").scopes())
	-- add_simple(";D?", "Debugging: Show Vairable Scope")

	setKey("n", ";DH", require("dap.ui.widgets").hover)
	setKey("n", ";DC", function()
		d.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end)
	setKey("n", ";DB", function()
		d.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	setKey("n", ";DR", function()
		d.repl.open({}, "vsplit")
	end)
	setKey("n", ";D<Space>", ui.toggle)
end

add_simple(";D<Space>", "Debugging: [T]oggle Dap-UI")
add_simple(";DT", "Debugging: [T]oggle Breakpoint")
add_simple(";DC", "Debugging: Create Breakpoint with [C]ondition")
add_simple(";DH", "Debugging: Display [H]over of Event")
add_simple(";DB", "Debugging: Create [B]reakpoint with log")
add_simple(";DR", "Debugging: Open [R]epl")
add_simple("F2", "Debugging: Step Over")
add_simple("F3", "Debugging: Step Into")
add_simple("F4", "Debugging: Step Out")
add_simple("F5", "Debugging: Continue")

-------------------------------------------------------------------------------

-------------------------
-- => Other Binds
-------------------------
-- <leader>df -> disable formatting (null_ls)
add_simple("<Leader>df", "Null LS: Disable Formatter in current buffer")

M.legend = legend.legend

return M
