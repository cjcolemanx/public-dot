local status, lsp = pcall(require, "lspconfig")
if not status then
	-- print("ERROR: plugin 'nvim-lspconfig' is unavailable")
	return
end

local util = require("lspconfig").util
local protocol = require("vim.lsp.protocol")

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

-- CMP w/ LSP
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Servers
local cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" }

lsp.flow.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = cmd,
	init_options = { hostInfo = "neovim" },
	capabilities = capabilities,
})

lsp.emmet_ls.setup({
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
	cmd = { "emmet-ls", "--stdio" },
	init_options = { hostInfo = "neovim" },
	capabilities = capabilities,
})

lsp.sourcekit.setup({
	on_attach = on_attach,
})

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

lsp.marksman.setup({
	on_attach,
})

lsp.sumneko_lua.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

-- TODO:
-- nvim_lsp.tailwindcss.setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
})

-- Diagnostics
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
