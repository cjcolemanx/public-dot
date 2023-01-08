local opts = { buffer = true, silent = false }
local api = vim.api
local augroup = api.nvim_create_augroup
local aucommand = api.nvim_create_autocmd
local map = vim.keymap.set

-- Markdown
local md_group = augroup("MarkdownMappings", { clear = false })

aucommand({ "FileType" }, {
	group = md_group,
	pattern = "markdown",
	callback = function()
		map("n", "<leader>t", function()
			local unchecked = "- [ ]"
			local checked = "- [x]"
			local line = api.nvim_get_current_line()
			local pos = api.nvim_win_get_cursor(0)

			if string.sub(line, 1, 5) == unchecked then
				print("toggle TODO: DONE")
				api.nvim_buf_set_text(0, pos[1] - 1, 0, pos[1] - 1, 5, { checked })
			elseif string.sub(line, 1, 5) == checked then
				print("toggle TODO: INCOMPLETE")
				api.nvim_buf_set_text(0, pos[1] - 1, 0, pos[1] - 1, 5, { unchecked })
			end
		end, opts)
	end,
})

-- Lua
-- local lua_group = augroup("LuaMappings", { clear = false })

-- FIXME: Not Working : (
-- aucommand({ "FileType" }, {
-- 	group = lua_group,
-- 	pattern = "lua",
-- 	callback = function()
-- 		map("n", "<leader>t", function()
-- 			local unchecked = {
-- 				"-- TODO: [ ]",
-- 				"-- [ ]",
-- 				"--[[ TODO: [ ]",
-- 				"--[[ [ ]",
-- 			}
-- 			local checked = {
-- 				"-- TODO: [x]",
-- 				"-- [x]",
-- 				"--[[ TODO: [x]",
-- 				"--[[ [x]",
-- 			}
-- 			local line = api.nvim_get_current_line()
-- 			local pos = api.nvim_win_get_cursor(0)
-- 			print("hello")
--
-- 			local td_string = ""
-- 			local in_comment = false
-- 			local start_pos_of_td
-- 			for i, char in line do
-- 				if char == "-" then
-- 					if not in_comment then
-- 						in_comment = true
-- 					else
-- 						start_pos_of_td = i
-- 					end
-- 				end
-- 				if in_comment then
-- 					td_string = td_string .. char
-- 				end
-- 				if char == "]" then
-- 					in_comment = false
-- 					td_string = td_string .. char
-- 				end
-- 			end
--
-- 			local index = 1
-- 			while index < 4 do
-- 				if unchecked[index] == td_string then
-- 					api.nvim_buf_set_text(
-- 						0,
-- 						pos[1] - 1,
-- 						start_pos_of_td,
-- 						pos[1] - 1,
-- 						string.len(unchecked[index]),
-- 						{ checked[index] }
-- 					)
-- 				elseif checked[index] == td_string then
-- 					api.nvim_buf_set_text(
-- 						0,
-- 						pos[1] - 1,
-- 						start_pos_of_td,
-- 						pos[1] - 1,
-- 						string.len(checked[index]),
-- 						{ unchecked[index] }
-- 					)
-- 				end
-- 				index = index + 1
-- 			end
-- 		end, opts)
-- 	end,
-- })
