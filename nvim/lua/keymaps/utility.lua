-- local status, legendary = pcall(require, "legendary")
-- if not status then
-- 	return
-- end

-------------------------
-- => Bind
-------------------------
print("I loaded")

vim.keymap.set("n", ";cc", require("tools.integrated.cheat").cht)
-- vim.keymap.set("n", ";<Space>l", require("ui.popups.buffer-dev-info").show_buffer_dev_info)

-- legendary.keymap({ ";sc", ""})
