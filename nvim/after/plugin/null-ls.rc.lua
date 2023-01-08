local status, null_ls = pcall(require, "null-ls")

if not status then
	-- print("ERROR: plugin 'null-ls' is unavailable")
	return
end

local M = {}

-- local utils = require("utils")
-- local nls_utils = require("config.lsp.null-ls.utils")
-- local nls_sources = require("null-ls.sources")

local setKey = vim.keymap.set

-- Default to Allow Autoformatting
M.autoformat = true

-- Used to Quickly Toggle the Autoformat On/Off for a buffer
function M.toggle()
	M.autoformat = not M.autoformat
	vim.g.null_ls_autoformat_enabled = not vim.g.null_ls_autoformat_enabled
	if M.autoformat then
		-- utils.info("Enabled format on save", "Formatting")
		print("Enabled format on save", "Formatting")
	else
		-- utils.warn("Disabled format on save", "Formatting")
		print("Disabled format on save", "Formatting")
	end
end

setKey("n", "<leader>df", function()
	M.toggle()
end)
-- setKey("n", "<leader>1", "<cmd>TroubleToggle<cr>", snr)

null_ls.setup({
	on_attach = function(client, bufnr)
		if M.autoformat then
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup_format,
					buffer = 0,
					callback = function()
						-- vim.lsp.buf.formatting_seq_sync()
						if M.autoformat then
							vim.lsp.buf.format()
						end
					end,
				})
			end
		end
	end,
	sources = {
		-- Code Actions
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.code_actions.refactoring,

		-- Completion
		null_ls.builtins.completion.luasnip,
		null_ls.builtins.completion.spell,
		null_ls.builtins.completion.tags,

		-- Diagnostics
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.stylelint,

		-- Formatters
		-- null_ls.builtins.formatting.csharpier,
		null_ls.builtins.formatting.fixjson,
		-- null_ls.builtins.formatting.lua_format,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.formatting.stylua,

		-- Hover
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.hover.printenv,
	},
})
