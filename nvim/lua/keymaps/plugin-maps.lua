local M = {}

-- Setup
local setKey = vim.keymap.set
local cmd = vim.cmd

-- Opts
local silent = { silent = true }
local snr = { silent = true, noremap = true }

-------------------------
-- => Comment
-------------------------
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

	return {
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
end

-------------------------
-- => CMP
-------------------------
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
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		-- Scroll Docs Or Restore Line To Pre-Completion
		["<C-d>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.scroll_docs(4)
			else
				cmp.abort()
			end
		end),
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

		--
		["<C-l>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				-- fallback()
				-- cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Select, select = true })
			end
		end, { "i", "s" }),

		["<C-h>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-i>"] = cmp.mapping.complete(),
		["<C-x>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<C-Space>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}
end

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
	setKey("n", ";t", function()
		builtin.help_tags()
	end)
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
	setKey("n", ";<space>r", function()
		builtin.reloader()
	end)
	setKey("n", ";<space>lg", function()
		builtin.git_branches()
	end)
	setKey("n", ";<space>la", function()
		builtin.git_commits()
	end)
	setKey("n", ";<space>hl", function()
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
	return {
		defaults = {
			mappings = {
				n = {
					["q"] = actions.close,
					["<cr>"] = actions.select_vertical,
					["<leader><Space>"] = actions.select_vertical,
					["<c-u>"] = actions.select_vertical,
					["<C-o>"] = actions.select_vertical,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
				},
				i = {
					["<esc>"] = actions.close,
					["<leader><Space>"] = actions.select_vertical,
					["<C-o>"] = actions.select_vertical,
					["<c-j>"] = actions.move_selection_next,
					["<c-k>"] = actions.move_selection_previous,
				},
			},
		},
		pickers = {
			help_tags = {
				mappings = {
					n = {
						["<cr>"] = actions.select_vertical,
						["<C-Space>"] = actions.select_vertical,
						["<leader><Space>"] = actions.select_vertical,
						["<C-o>"] = actions.select_vertical,
					},
				},
			},
			man_pages = {
				mappings = {
					n = {
						["<cr>"] = actions.select_vertical,
						["<C-Space>"] = actions.select_vertical,
						["<leader><Space>"] = actions.select_vertical,
						["<C-o>"] = actions.select_vertical,
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
						-- ["N"] = fb_actions.create,
						-- ["h"] = fb_actions.goto_parent_dir,
						["i"] = function()
							vim.cmd("startinsert")
						end,
						["/"] = function()
							vim.cmd("startinsert")
						end,
						-- ["<C-j>"] = actions.results_scrolling_down(),
						-- ["<C-k>"] = actions.results_scrolling_up(),
						-- ["<C-j>"] = actions.move_selection_next(prompt_bufnr),
						-- ["<C-k>"] = actions.preview_scrolling_up(1),
					},
				},
			},
		},
	}
end

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
	buf_set_keymap("n", ";;d", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	buf_set_keymap("n", ";d", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	buf_set_keymap("n", ";i", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	-- buf_set_keymap("n", ";k", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

	-- LSP Saga
	-- bnmap("gd", "<Cmd>Lspsaga lsp_finder<CR>")
	bnmap(";p", "<Cmd>Lspsaga peek_definition<CR>")
	bnmap(";k", "<Cmd>Lspsaga hover_doc<CR>")
	bnmap(";s", "<cmd>Lspsaga signature_help<CR>")
	bnmap(";go", "<cmd>Lspsaga show_line_diagnostics<CR>")
	bnmap(";gn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	bnmap(";gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	bnmap(";gr", "<cmd>Lspsaga rename<CR>")
	bnmap(";a", "<cmd>Lspsaga code_action<CR>")

	setKey("n", "<M-CR>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
	setKey("t", "<ESC>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
	setKey("t", "<M-CR>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

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

-------------------------
-- => NvimTree
-------------------------
function M.nvimTree_binds()
	setKey("", "<C-b>", ":NvimTreeToggle<CR>", silent)
	setKey("n", "<leader>b", ":NvimTreeFocus<CR>", silent)
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
			{ key = "gr", action = "git_add", action_cb = helpers.git_add },
			{ key = "<C-f>", action = "preview file", action_cb = helpers.launch_find_files },
			{ key = "<C-g>", action = "live grep", action_cb = helpers.launch_live_grep },
			{ key = "<C-p>", action = "open context menu", action_cb = helpers.tree_actions_menu },
			{ key = "<C-c>", action = "change global cwd", action_cb = helpers.change_root_to_global_cwd },
			{ key = ";f", cb = helpers.launch_find_files },
			{ key = ";g", cb = helpers.launch_live_grep },
			-- API
			{ key = "<leader>r", action_cb = nt.tree.reload },
			{ key = "<leader>g", cb = nt.tree.toggle_gitignore_filter },
			{ key = "?", cb = nt.node.show_info_popup },
			{ key = { "<ESC>", "q" }, cb = nt.tree.close },
			{ key = "<leader>ms", cb = nt.marks.select },
			{ key = "gml", cb = nt.marks.navigate.next },
			{ key = "gmh", cb = nt.marks.navigate.prev },
		},
	}
end

-------------------------
-- => Trouble
-------------------------
function M.trouble_binds()
	setKey("n", "<leader>1", "<cmd>TroubleToggle<cr>", snr)
end

-------------------------
-- => Zen Mode
-------------------------
function M.zenMode_binds()
	setKey("n", "<leader>z", ":ZenMode<CR>")
end

-------------------------
-- => High-Str
-------------------------
function M.high_str_binds()
	setKey("v", "<leader>h1", ":<c-u>HSHighlight 1<CR>", snr)
	setKey("v", "<leader>h2", ":<c-u>HSHighlight 2<CR>", snr)
	setKey("v", "<leader>h3", ":<c-u>HSHighlight 3<CR>", snr)
	setKey("v", "<leader>h4", ":<c-u>HSHighlight 4<CR>", snr)
	setKey("v", "<leader>h5", ":<c-u>HSHighlight 5<CR>", snr)
	setKey("v", "<leader>h6", ":<c-u>HSHighlight 6<CR>", snr)
	setKey("v", "<leader>h7", ":<c-u>HSHighlight 7<CR>", snr)
	setKey("v", "<leader>h8", ":<c-u>HSHighlight 8<CR>", snr)
	setKey("v", "<leader>h9", ":<c-u>HSHighlight 9<CR>", snr)
	setKey("v", "<leader>rh", ":<c-u>HSRmHighlight<CR>", snr)
end

-------------------------
-- => Tabby
-------------------------
function M.tabby()
	setKey("n", "<leader><leader>rt", ":TabRename ")
end

-------------------------
-- => Documentation
-------------------------
-- M.mappings = {
--   Comment = {
--     g = {
--       name = "Comment",
--       h = { "Toggle line comment" },
--       k = { "Add newline comment above" },
--       j = { "Add newline comment below" },
--       l = { "Append comment to EOL" },
--       b = { "Toggle block comment" },
--     },
--   },
--   CMP = {
--     ["<C-j>"] = { "Select next CMP item" },
--     ["<M-j>"] = {},
--     ["<down>"] = {},
--     ["<C-k>"] = {},
--     ["<M-k>"] = {},
--     ["<up>"] = {},
--     ["<C-u>"] = {},
--     ["<C-e>"] = {},
--   },
--   Telescope = {},
--   LSPSaga = {},
--   NvimTree = {},
--   Trouble = {},
--   ZenMode = {},
--   HighStr = {},
--   Tabby = {},
-- }

return M
