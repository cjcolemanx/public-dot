local status, null_ls = pcall(require, "null-ls")

if not status then
	return
end

local M = {}

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

require("keymaps.plugin-maps").null_ls(M.toggle)

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
		null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.code_actions.refactoring,

		-- Completion
		null_ls.builtins.completion.luasnip,
		null_ls.builtins.completion.spell,
		null_ls.builtins.completion.tags,

		-- Diagnostics
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.stylelint,
		-- null_ls.builtins.diagnostics.shellcheck, -- handled by lsp

		-- Formatters
		-- null_ls.builtins.formatting.csharpier,
		null_ls.builtins.formatting.fixjson,
		-- null_ls.builtins.formatting.lua_format,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.formatting.stylua,

		-- Hover
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.hover.printenv,
	},
})
