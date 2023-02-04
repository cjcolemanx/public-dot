local status, lsp = pcall(require, "lspconfig")
if not status then
	-- print("ERROR: plugin 'nvim-lspconfig' is unavailable")
	return
end

local util = require("lspconfig").util
local protocol = require("vim.lsp.protocol")

-- Sets up Language Server on Buffer attach
local on_attach = function(client, bufnr)
	local function bmap(mode, lhs, rhs)
		mode = mode or "n"
		local opts = {
			noremap = true,
			silent = true,
		}

		if type(rhs) == "function" then
			opts.callback = rhs
			rhs = ""
		end

		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
	end

	local function bnmap(...)
		bmap("n", ...)
	end

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Completion
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings
	local opts = { noremap = true, silent = true }
	require("keymaps.plugin-maps").lsp_maps_on_attach(bmap, bnmap, buf_set_keymap, opts)
end

-------------------------
-- => CMP
-------------------------
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-------------------------
-- => SERVER SETUP
-------------------------
-- TypeScript AND JavaScript
local ts_js_cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" }

-------------------------
-- => JavaScript + Web
-------------------------
lsp.flow.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		local ts_utils = require("nvim-lsp-ts-utils")

		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,
			import_all_timeout = 5000,
			eslint_enable_code_actions = false,
			eslint_enable_disable_comments = false,
			eslint_bin = "eslint",
			eslint_config_fallback = nil,
			eslint_enable_diagnostics = false,
			update_imports_on_move = true,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		ts_utils.setup_client(client)
		require("keymaps.lsp").javascript(bufnr)
	end,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = ts_js_cmd,
	init_options = { hostInfo = "neovim" },
	capabilities = capabilities,
})

-- lsp.emmet_ls.setup({
-- 	on_attach = on_attach,
-- 	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
-- 	cmd = { "emmet-ls", "--stdio" },
-- 	init_options = { hostInfo = "neovim" },
-- 	capabilities = capabilities,
-- })

-- TODO:
-- nvim_lsp.tailwindcss.setup {}

-------------------------
-- => Vue
-------------------------
-- FIXME: Probably wanna switch to Volar....
-- lsp.vuels.setup({
-- 	on_attach = { on_attach },
-- 	filetypes = { "vue" },
-- 	cmd = { "vls" },
-- 	init_options = {
-- 		{
-- 			config = {
-- 				css = {},
-- 				emmet = {},
-- 				html = {
-- 					suggest = {},
-- 				},
-- 				javascript = {
-- 					format = {},
-- 				},
-- 				stylusSupremacy = {},
-- 				typescript = {
-- 					format = {},
-- 				},
-- 				vetur = {
-- 					completion = {
-- 						autoImport = true,
-- 						tagCasing = "kebab",
-- 						useScaffoldSnippets = false,
-- 					},
-- 					format = {
-- 						defaultFormatter = {
-- 							js = "prettierd",
-- 							ts = "prettierd",
-- 						},
-- 						defaultFormatterOptions = {},
-- 						scriptInitialIndent = false,
-- 						styleInitialIndent = false,
-- 					},
-- 					useWorkspaceDependencies = false,
-- 					validation = {
-- 						script = true,
-- 						style = true,
-- 						template = true,
-- 					},
-- 				},
-- 			},
-- 		},
-- 	},
-- 	root_dir = root_pattern("package.json", "vue.config.js"),
-- })

-------------------------
-- => Markdown
-------------------------
lsp.marksman.setup({
	on_attach,
})

-------------------------
-- => Lua
-------------------------
lsp.sumneko_lua.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "use" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

-------------------------
-- => Rust
-------------------------
lsp.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				allFeatures = true,
				command = "clippy",
			},
			procMacro = {
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
			},
		},
	},
})

-------------------------
-- => Shell
-------------------------
lsp.bashls.setup({
	on_attach = on_attach,
})

-------------------------
-- => C, C++
-------------------------
lsp.sourcekit.setup({
	on_attach = on_attach,
})

-------------------------
-- => Diagnostics
-------------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = false,
	float = {
		source = "always",
	},
})

protocol.CompletionItemKind = {
	"", -- Text
	"", -- Method
	"", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"ﴯ", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}
count_chars = {
	[1] = "",
	[2] = "₂",
	[3] = "₃",
	[4] = "₄",
	[5] = "₅",
	[6] = "₆",
	[7] = "₇",
	[8] = "₈",
	[9] = "₉",
	["+"] = "",
}

-- {
--  default = {
--     -- if you change or add symbol here
--     -- replace corresponding line in readme
--     Text = "",
--     Method = "",
--     Function = "",
--     Constructor = "",
--     Field = "ﰠ",
--     Variable = "",
--     Class = "ﴯ",
--     Interface = "",
--     Module = "",
--     Property = "ﰠ",
--     Unit = "塞",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "פּ",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
--   },
--   codicons = {
--     Text = "",
--     Method = "",
--     Function = "",
--     Constructor = "",
--     Field = "",
--     Variable = "",
--     Class = "",
--     Interface = "",
--     Module = "",
--     Property = "",
--     Unit = "",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
--   },
-- nvim_lua = "",
-- treesitter = "",
-- path = "ﱮ",
-- buffer = "﬘",
-- zsh = "",
-- vsnip = "",
-- spell = "暈",
-- }
