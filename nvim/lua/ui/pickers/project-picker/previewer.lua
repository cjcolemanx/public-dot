---@diagnostic disable: deprecated
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

-- Opts
local title = "\\ Project Info /"

-- Jobs
-- local job_git_status = { "git", "-C", nil, "status" }
local job_files = { "find", ".", "-type", "f" }
local job_folders = { "find", ".", "-maxdepth", "1", "-type", "d" }

local preview_text = {
	[1] = "CWD: ",
	[2] = "Git Repo: ",
	[3] = "Files: ",
	[4] = "Folders: ",
	[5] = "                                                         ",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = "Location of Selected: ",
	[10] = "Git Repo: ",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "",
}

local redraw_preview = function(bufnr)
	local printable = {}

	for _, v in ipairs(preview_text) do
		table.insert(printable, v)
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, printable)
end
local init_draw_preview = function(bufnr) end

local define_preview = function(_self, _entry, _status)
	-- PRINT:
	-- print(vim.inspect(_entry))
	-- PRINT:
	-- print(vim.inspect(_self))
	-- PRINT:
	-- print(vim.inspect(_status))
	local state = _self.state
	local bufnr, winid = state.bufnr, state.winid

	-- TODO: Trim cwd (use vim.fn.expand($HOME) and lua string methods)
	local cwd = vim.fn.getcwd()
	preview_text[1] = "CWD: " .. cwd

	local location = _entry.value.path
	preview_text[9] = "Location of Selected: " .. location

	-- Predraw
	-- redraw_preview(bufnr)

	-- Check Git Statuses
	require("telescope.previewers.utils").job_maker({ "git", "-C", cwd, "status" }, bufnr, {
		callback = function(_, content)
			if not content[1] then
				preview_text[2] = "Git Repo: Not a Git Repo"
			else
				-- preview_text[2] = "Git Repo: " .. content[1]
				preview_text[2] = "Git Repo: Yes"
			end
			-- require("telescope.previewers.utils").job_maker({ "git", "-C", location, "status" }, bufnr, {
			-- 	callback = function(_, content)
			-- 		if not content[1] then
			-- 			preview_text[10] = "Git Repo: Not a Git Repo"
			-- 		else
			-- 			preview_text[10] = "Git Repo: Yes"
			-- 		end
			-- 	end,
			-- })
			redraw_preview(bufnr)
		end,
	})

	-- Check for (Add Project)

	-- Check Files and Folders (CWD)
	-- utils.job_maker({ "find", ".", "-type", "f" }, bufnr, {
	-- 	callback = function(_, content)
	-- 		if not content or table.maxn(content) == 0 then
	-- 			preview_text[3] = "Files: None"
	-- 		else
	-- 			local number_of = table.maxn(content)
	-- 			preview_text[3] = "Files: " .. number_of
	-- 		end
	-- 		-- PRINT:
	-- 		print(vim.inspect(table.maxn(content)))
	-- 	end,
	-- })
	-- utils.job_maker({ "find", ".", "-maxdepth", "1", "-type", "d" }, bufnr, {
	-- 	callback = function(_, content)
	-- 		if not content or table.maxn(content) == 0 then
	-- 			preview_text[4] = "Folders: None"
	-- 		else
	-- 			local number_of = table.maxn(content)
	-- 			preview_text[4] = "Folders: " .. number_of
	-- 		end
	-- 	end,
	-- })
end

local previewer = previewers.new_buffer_previewer({
	define_preview = define_preview,
	title = title,
})

return { previewer = previewer }
