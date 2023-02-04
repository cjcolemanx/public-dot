local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	-- print("ERROR: plugin 'nvim-treesitter' is unavailable")
	return
end

local maps = require("keymaps.plugin-maps").treeSitter()
local to_maps = maps.textobjects

ts.setup({
	auto_install = true,
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_aoutcmd = false, -- To Work with Comment.nvim
		-- javascript = {
		--   __default = "// %s",
		--   jsx_element = "{/* %s */}",
		--   jsx_fragment = "{/* %s */}",
		--   jsx_attribute = "{/* %s */}",
		--   comment = "{/* %s */}",
		-- },
	},
	ensure_installed = {
		-- "angular",
		"bash",
		"c_sharp",
		"css",
		"fish",
		-- "gdresource",
		"gdscript",
		"gitignore",
		"graphql",
		"help", -- vim help files
		"html",
		"http",
		"java",
		"javascript",
		"jsdoc",
		"json",
		"latex",
		"lua",
		"markdown",
		"php",
		"python",
		"regex",
		"rust",
		"sql",
		"scss",
		"sxhkdrc",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
		-- "swift",
	},
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	incremental_selection = {
		enable = true,
		keymaps = maps.incremental_selection,
	},
	matchup = {
		enable = true,
	},
	sync_install = true,
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = to_maps.select,
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = to_maps.move.goto_next_start,
			goto_next_end = to_maps.move.goto_next_end,
			goto_previous_start = to_maps.move.goto_previous_start,
			goto_previous_end = to_maps.move.goto_previous_end,
		},
	},
	swap = {
		enable = true,
		swap_next = maps.swap.next,
		swap_previous = maps.swap.previous,
	},
	-- Nvim-TS-Rainbow
	rainbow = {
		enable = true,
		disable = {}, -- list of languages to disable highlighting for
		extendend_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table
		max_file_lines = nil, -- Do not enable for files with more than n lines
		-- colors = {},
		-- termcolors = {},
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
