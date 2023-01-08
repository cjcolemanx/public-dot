local M = {}

-- TODO:  Refactor vim.cmd with helpers
-- function M.showPopup() end

function M.makeTabList(all_tabs, cur_tab)
	local tab_list = {}
	for _, tab in ipairs(all_tabs) do
		if tab.tabnr ~= cur_tab then
			table.insert(tab_list, tab.tabnr)
		end
	end
	return tab_list
end

--[[
Checks if there is a next tab to move the buffer to, then moves it forward
if there is.
--]]
function M.sendToNextTab()
	local cur_buf = vim.fn.bufnr()
	local cur_tab = vim.fn.tabpagenr()

	vim.cmd({ cmd = "tabn" })
	local target_tab = vim.fn.tabpagenr()

	-- DONT loop
	if target_tab ~= 1 then
		vim.cmd({ cmd = "vsplit" })
		vim.cmd({ cmd = "b", args = { cur_buf } })
		vim.cmd({ cmd = "tabp" })
		vim.cmd({ cmd = "q!" })
	else
		-- Don't move to next tab
		vim.cmd({ cmd = "tabp" })
	end
end

--[[
Checks if there is a previous tab to move the buffer to, then moves it backwards 
one tab if there is.
--]]
function M.sendToPreviousTab()
	local cur_buf = vim.fn.bufnr()
	local cur_tab = vim.fn.tabpagenr()

	-- Get last tab index
	-- vim.cmd({ cmd = "tabm 0" })
	-- local last_index = vim.fn.bufnr()
	-- vim.cmd({ cmd = "tabm", args = { cur_tab - 1 } })

	-- DONT loop
	if cur_tab ~= 1 then
		vim.cmd({ cmd = "tabp" })
		-- local target_tab = vim.fn.tabpagenr()
		vim.cmd({ cmd = "vsplit" })
		vim.cmd({ cmd = "b", args = { cur_buf } })
		vim.cmd({ cmd = "tabn" })
		vim.cmd({ cmd = "q!" })
		-- else
		--   -- Don't move to next tab
		--   vim.cmd({ cmd = "tabn" })
	end
end

--[[
Creates a new tab and moves the target buffer to that tab.

buf: (number) Buffer number
--]]
function M.sendToNewTab(buf)
	local to_move = buf.bufnr
	local cur_tab_position = vim.fn.tabpagenr()

	-- Move to last tab
	vim.cmd({ cmd = "tabm" })

	-- Create a new tab and display the stored buffer..
	vim.cmd({ cmd = "tabnew" })
	vim.cmd({ cmd = "b", args = { to_move } })

	-- ..And get its index
	local new_tab_position = vim.fn.tabpagenr()

	-- Go back to previous tab..
	vim.cmd({ cmd = "tabp" })

	-- ..And move it back to its initial position
	vim.cmd({ cmd = "tabm", args = { cur_tab_position - 1 } })

	-- Close the old buffer
	vim.cmd({ cmd = "q!" })
end

--[[
Sends the current window to a different tab.

tab_nr: (number) The target tab to send the buffer to.
--]]
function M.sendToTab(tab_nr)
	local cur_buf = vim.fn.bufnr()
	local start_tab = vim.fn.tabpagenr()
	local cur_tab = start_tab

	-- Go to target
	while cur_tab ~= tab_nr do
		if tab_nr > start_tab then
			vim.cmd({ cmd = "tabn" })
		end
		if tab_nr < start_tab then
			vim.cmd({ cmd = "tabp" })
		end
		cur_tab = vim.fn.tabpagenr()
	end

	vim.cmd({ cmd = "vsplit" })
	vim.cmd({ cmd = "b", args = { cur_buf } })

	-- Reverse
	while cur_tab ~= start_tab do
		if cur_tab > start_tab then
			vim.cmd({ cmd = "tabp" })
		end
		if cur_tab < start_tab then
			vim.cmd({ cmd = "tabn" })
		end
		cur_tab = vim.fn.tabpagenr()
	end

	vim.cmd({ cmd = "q!" })
end

return M
