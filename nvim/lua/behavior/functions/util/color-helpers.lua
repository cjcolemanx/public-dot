local M = {}

-- local function get_hl_group_hex_codes(group, term)
-- 	local output = vim.fn.execute("hi " .. group)
-- 	return vim.fn.matchstr(output, term .. "=\zsS*")
-- end

-- M.get_hl_group_hex_codes = get_hl_group_hex_codes
function M.get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if not ok then
		return
	end
	for _, key in pairs({ "foreground", "background", "special" }) do
		if hl[key] then
			hl[key] = string.format("#%06x", hl[key])
		end
	end
	return hl
end

return M
