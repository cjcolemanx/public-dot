local M = {}

local user = {
	db_location = nil,
}

local default = {
	db_location = vim.fn.stdpath("config") .. "/data/project-locations.txt",
}

-- Create The File
local function create_db_file()
	local command = { "touch", user.db_location }
	local opts = {
		on_stdout = function()
			require("notify").notify(
				"Telescope Projects: Project Database Created",
				vim.log.levels.SUCCESS,
				{ timeout = 200 }
			)
		end,
	}

	vim.fn.jobstart(command, opts)
end

-- Validate Existence
local function validate_db_file()
	if vim.fn.filereadable(user.db_location) == 0 then
		create_db_file()
	else
		return
	end
end

function M.setup(opts)
	if opts ~= nil then
		if opts.db_location ~= nil then
			user.db_location = opts.db_location
		else
			user.db_location = default.db_location
		end
	else
		user = default
	end

	validate_db_file()
end

M.user_opts = user

return M
