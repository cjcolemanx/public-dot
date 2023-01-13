local status, db = pcall(require, "dashboard")

if not status then
	return
end

local _, img_func = pcall(require, "ui.dashboard.ascii")

local db_image = img_func.get_random_image()

-- DEBUGGING IMAGES:
-- db_image = img_func.use_specific_images("anime", "anime_01")

db.custom_header = db_image

-- OPTIONS
db.confirm_key = "o" -- string type key that do confirm in center select
db.hide_tabline = false -- boolean default is true.it will hide tabline in dashboard buffer and auto open in other buffer

db.custom_center = {
	{
		icon = "  ",
		desc = "Open a new buffer                         ",
		action = "DashboardNewFile",
		shortcut = " n",
	},
	{
		icon = "  ",
		desc = "Create a New File                         ",
		action = "DashboardNewFile",
		shortcut = " N",
	},
	{
		icon = "  ",
		desc = "File Browser                              ",
		action = "Telescope file_browser",
		shortcut = ";f",
	},
	{
		icon = "  ",
		desc = "Telescope sessions                        ",
		shortcut = ";s",
		action = function()
			require("ui.pickers.session-picker").open()
		end,
	},
	{
		icon = "  ",
		desc = "Update Neovim Plugins                     ",
		action = "PackerUpdate",
		shortcut = " u",
	},
	{
		icon = "  ",
		desc = "Open dotfiles                             ",
		action = function()
			vim.cmd("NvimTreeClose")
			vim.cmd("lcd ~/.config")
			vim.cmd("e updates.md")
			vim.cmd("lcd %:h")
		end,
		shortcut = ";c",
	},
	{
		icon = "  ",
		desc = "Edit Nvim Config                          ",
		action = function()
			vim.cmd("NvimTreeClose")
			vim.cmd("lcd ~/.config/nvim")
			vim.cmd("e init.lua")
			vim.cmd("lcd %:h")
		end,
		shortcut = ";g",
	},
	{
		icon = "  ",
		desc = "See The Planets                          ",
		shortcut = " ;p",
		action = function()
			require("telescope.builtin").planets()
		end,
	},
	{
		icon = "  ",
		desc = "Quit                                ",
		action = "Telescope dotfiles path=~/.config",
		shortcut = "q or ESC",
	},
}

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DashboardMappings", { clear = true }),
	pattern = "dashboard",
	callback = function()
		local winnr = vim.api.nvim_get_current_win()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.wo[winnr].cursorline = true
		-- require("behavior.functions.dashboard").add_dashboard_cursoritem_highlights(bufnr)

		vim.keymap.set("n", "n", "<Cmd>DashboardNewFile<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", "N", "<Cmd>DashboardNewFile<CR>:saveas ", { silent = true, buffer = true })
		vim.keymap.set("n", "q", "<Cmd>NvimTreeClose<CR><Cmd>q!<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", "<ESC>", "<Cmd>NvimTreeClose<CR><Cmd>q!<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", ";p", "<CMD>Telescope planets<CR>", { silent = true, buffer = true })
		vim.keymap.set(
			"n",
			";c",
			"<Cmd>NvimTreeClose<CR>:lcd ~/.config/<CR>:e updates.md<CR>:lcd %:h<CR>",
			{ silent = true, buffer = true }
		)
		vim.keymap.set(
			"n",
			";g",
			"<Cmd>NvimTreeClose<CR>:lcd ~/.config/nvim<CR>:e init.lua<CR>:lcd %:h<CR>",
			{ silent = true, buffer = true }
		)
		vim.keymap.set("n", "u", "<Cmd>PackerInstall<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", "<Space>", "<Cmd>DashboardNewFile<CR><Cmd>lcd %:h<CR>", { silent = true, buffer = true })
		-- vim.keymap.set("n", ";r", "<CMD>DashboardNewFile<CR><CMD>Dashboard<CR>", { silent = true, buffer = true })
		-- vim.keymap.set("n", ";r", function()
		-- 	db.custom_header = img_func.get_random_image()
		-- 	require("dashboard"):instance(true)
		-- end, { silent = false, buffer = true })
		-- vim.keymap.set("n", ";r", function()
		-- 	-- local bufinfo = vim.api.nvim__buf_stats(0)
		-- 	-- print(vim.inspect(bufinfo))
		-- 	-- print("Changing dashboard picture")
		-- 	-- db.custom_header = img_func.get_randow_image()
		--
		-- end, { silent = true, buffer = true })

		-- Cleanup
		vim.api.nvim_create_autocmd("BufLeave", {
			group = "DashboardMappings",
			callback = function()
				vim.wo[winnr].cursorline = false
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = "DashboardMappings",
	callback = function(args)
		-- TODO: close Mind (use 'set filetype?' maybe)

		if args.file == "dashboard" then
			vim.cmd("MindClose")
		end
		-- local newbuf = vim.api.nvim_buf_get_var(0, "filetype")
		-- print(vim.inspect(newbuf))
		-- if vim.g.mind_nvim_main_open or vim.g.mind_nvim_project_open then
		-- 	vim.cmd("MindClose")
		-- end
	end,
})

require("keymaps.plugin-maps").dashboard()
