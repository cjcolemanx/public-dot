local status, lualine = pcall(require, "lualine")
if not status then
	-- print("ERROR: plugin 'lualine' is unavailable")
	return
end

local fn = vim.fn
local opt = vim.opt

function getTime()
	-- return fn.strftime('[ %H:%M:%S ]')
	return fn.strftime("｢ %H:%M:%S ｣")
end

function getDate()
	return fn.strftime("%m/%d %a")
end

-- Shows Whether Autoformat Is Enabled and Via Which Client It Is Performed
local getAutoformatStatus = function()
	-- AF Enabled
	if vim.g.null_ls_autoformat_enabled then
		local formatter = nil

		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			formatter = client.name
		end

		return "[" .. formatter .. "]"
	end

	-- AF Disabled
	return "[Auto Format OFF]"
end

local windowBufnr = function()
	return "Buf" .. vim.fn.bufnr()
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "duskfox",
		-- theme = "auto",
		-- theme = "nordfox",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {},
	},
	sections = {
		-- lualine_a = { "mode", { "buffers", mode = 1 } },
		lualine_a = { "mode", windowBufnr },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				newfile_status = true,
				path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
			getAutoformatStatus,
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			"encoding",
			"filetype",
			{
				"fileformat",
				symbols = {
					unix = " [LF]",
					dos = " [CRLF]",
					mac = " [CR]",
				},
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = { windowBufnr },
		lualine_b = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
		},
		lualine_z = { "progress", "location" },
	},
	winbar = {},
	extensions = { "nvim-tree" },
})
