local status, db = pcall(require, "dashboard")

if not status then
	return
end

-- local _, images = pcall(require, "ui.dashboard.ascii-art")
local _, img_func = pcall(require, "ui.dashboard.ascii")

-- type can be nil,table or function(must be return table in function)
-- if not config will use default banner
-- db.custom_header = img_func.add_logo_to_art(
-- 	images.neovim_01,
-- 	img_func.add_text_to_bottom(img_func.add_border_to_art(images.garfield), "LaSaGna", "~ ", " ~")
-- )

local dash_image = img_func.get_random_image()

if dash_image ~= nil then
	db.custom_header = img_func.get_random_image()
end

db.custom_center = {
	{
		icon = "  ",
		desc = "Open a new buffer                         ",
		action = "DashboardFindHistory",
		shortcut = "; e",
	},
	{
		icon = "  ",
		desc = "File Browser                              ",
		action = "Telescope file_browser",
		shortcut = "; f",
	},
	{
		icon = "  ",
		desc = "Telescope sessions                    ",
		shortcut = "; SPC s",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Update Neovim Packages                    ",
		action = "Telescope dotfiles path=~/.config",
		shortcut = "; u",
	},
	{
		icon = "  ",
		desc = "Open dotfiles                             ",
		action = "Telescope dotfiles path=~/.config",
		shortcut = "; c",
	},
	{
		icon = "  ",
		desc = "Edit Nvim Config                          ",
		action = "Telescope dotfiles path=~/.config",
		shortcut = "; o",
	},
	{
		icon = "  ",
		desc = "Quit                               ",
		action = "Telescope dotfiles path=~/.config",
		shortcut = "; q or ESC",
	},
	-- {
	--   icon = "  ",
	--   desc = "Find  File                              ",
	--   action = "Telescope find_files find_command=rg,--hidden,--files",
	--   shortcut = "SPC f f",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Find  word                              ",
	--   action = "Telescope live_grep",
	--   shortcut = "SPC f w",
	-- },
}
-- table type and in this table you can set icon,desc,shortcut,action keywords. desc must be exist and type is string
-- icon type is nil or string
-- icon_hl table type { fg ,bg} see `:h vim.api.nvim_set_hl` opts
-- shortcut type is nil or string also like icon
-- action type can be string or function or nil.
-- if you don't need any one of icon shortcut action ,you can ignore it.
-- db.custom_footer  -- type can be nil,table or function(must be return table in function)
-- db.preview_file_Path          -- string or function type that mean in function you can dynamic generate height width
-- db.preview_file_height        -- number type
-- db.preview_file_width         -- number type
-- db.preview_command            -- string type (can be ueberzug which only work in linux)
-- db.confirm_key                -- string type key that do confirm in center select
-- db.hide_statusline            -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
-- db.hide_tabline               -- boolean default is true.it will hide tabline in dashboard buffer and auto open in other buffer
-- db.hide_winbar                -- boolean default is true.it will hide the winbar in dashboard buffer and auto open in other buffer
-- db.session_directory = "~/.config/nvim/sessions" -- string type the directory to store the session file
-- db.session_auto_save_on_exit  -- boolean default is false.it will auto-save the current session on neovim exit if a session exists and more than one buffer is loaded
-- db.session_verbose            -- boolean default true.it will display the session file path on SessionSave and SessionLoad
-- db.header_pad                 -- number type default is 1
-- db.center_pad                 -- number type default is 1
-- db.footer_pad                 -- number type default is 1
--
-- -- example of db.custom_center for new lua coder,the value of nil mean if you
-- -- don't need this filed you can not write it
-- db.custom_center = {
--   {icon_hl={fg="color_code"},icon ="some icon",desc="some desc"} --correct
--   { icon = 'some icon' desc = 'some description here' } --correct if you don't action filed
--   { desc = 'some description here' }                    --correct if you don't action and icon filed
--   { desc = 'some description here' action = 'Telescope find files'} --correct if you don't icon filed
-- }
--
-- -- Custom events
-- DBSessionSavePre   -- a custom user autocommand to add functionality before auto-saving the current session on exit
-- DBSessionSaveAfter -- a custom user autocommand to add functionality after auto-saving the current session on exit
--
-- -- Example: Close NvimTree buffer before auto-saving the current session
-- autocmd('User', {
--     pattern = 'DBSessionSavePre',
--     callback = function()
--       pcall(vim.cmd, 'NvimTreeClose')
--     end,
-- })
--
--
-- -- Highlight Group
-- DashboardHeader DashboardCenter DashboardShortCut DashboardFooter
--
-- -- Command
--
-- DashboardNewFile  -- if you like use `enew` to create file,Please use this command,it's wrap enew and restore the statsuline and tabline
-- SessionSave,SessionLoad,SessionDelete

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DashboardMappings", { clear = true }),
	pattern = "dashboard",
	callback = function()
		vim.keymap.set("n", ";e", "<Cmd>DashboardNewFile<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", ";q", "<Cmd>NvimTreeClose<CR><Cmd>q!<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", "<ESC>", "<Cmd>NvimTreeClose<CR><Cmd>q!<CR>", { silent = true, buffer = true })
		vim.keymap.set(
			"n",
			";c",
			"<Cmd>NvimTreeClose<CR>:lcd ~/.config/<CR>:e updates.md<CR>",
			{ silent = true, buffer = true }
		)
		vim.keymap.set(
			"n",
			";o",
			"<Cmd>NvimTreeClose<CR>:lcd ~/.config/nvim<CR>:e init.lua<CR>",
			{ silent = true, buffer = true }
		)
		vim.keymap.set("n", ";u", "<Cmd>PackerInstall<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", ";r", function()
			local bufinfo = vim.api.nvim__buf_stats(0)
			print(vim.inspect(bufinfo))
			-- print("Changing dashboard picture")
			-- db.custom_header = img_func.get_randow_image()
		end, { silent = true, buffer = true })
	end,
})
