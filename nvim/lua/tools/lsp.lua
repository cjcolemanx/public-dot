local M = {}

M.lsp_servers = {
	-- 'angularls',
	"bashls",
	-- 'csharp_ls',
	"cssls",
	"cssmodules_ls",
	-- 'dockerls',
	-- "emmet-ls",
	-- "eslint_d",
	"eslint",
	-- 'html',
	-- 'intelephense', -- PHP
	"jdtls", -- Java
	-- 'jsonls',
	"marksman", -- Markdown
	-- "prettierd",
	-- 'textlab', -- LaTeX
	"tsserver",
	"sumneko_lua",
	"rust_analyzer",
	-- "stylelua",
	-- 'pyright
	-- 'sqlls,
	-- 'tailwindcss,
}

M.linters = {}
M.formatters = {}
M.dap = {}

return M
