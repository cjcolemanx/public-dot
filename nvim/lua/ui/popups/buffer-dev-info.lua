local M = {}

function M.show_buffer_dev_info()
	local raw = vim.inspect(vim.lsp.get_active_clients({ bufnr = 0 }))
	local obj = vim.lsp.get_active_clients({ bufnr = 0 })
	local details = {
		"server_cmd = " .. obj[1].config.cmd[1],
	}
	local display = {}

	vim.api.nvim_exec("vnew", true)
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_name(buf, "lsp_info-" .. buf)

	for s in raw:gmatch("[^\n]+") do
		table.insert(display, s)
	end

	vim.api.nvim_buf_set_lines(buf, 0, 0, false, display)
	-- vim.api.nvim_buf_set_lines(buf, 0, 0, false, details)

	-- require("notify").notify(display, "SUCCESS", { timeout = 500 })
end

-- function M.cht_cmd(cmd)
-- 	vim.api.nvim_exec("vnew", true)
-- 	vim.api.nvim_exec("terminal", true)
-- 	local buf = vim.api.nvim_get_current_buf()
-- 	vim.api.nvim_buf_set_name(buf, "cheatsheet-" .. buf)
-- 	vim.api.nvim_buf_set_option(buf, "filetype", "cheat")
-- 	vim.api.nvim_buf_set_option(buf, "syntax", lang)
--
-- 	local chan_id = vim.b.terminal_job_id
-- 	local cht_cmd = "curl cht.sh/" .. cmd
-- 	vim.api.nvim_chan_send(chan_id, cht_cmd .. "\r\n")
-- 	vim.cmd([[stopinsert]])
-- end

return M
