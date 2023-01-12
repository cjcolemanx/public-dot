local M = {}

--[[
Simply concats the tables of 2 image tables.

Picture 1 will always appear on top of Picture 2.

- Should be able to throw output back in to concat multiple

pic_1: (table)
pic_2: (table)
--]]
local function add_logo_to_art(pic_1, pic_2)
	local new_pic = {}
	for _, line in ipairs(pic_1) do
		table.insert(new_pic, line)
	end
	for _, line in ipairs(pic_2) do
		table.insert(new_pic, line)
	end
	return new_pic
end

M.add_logo_to_art = add_logo_to_art

--[[
Adds a border to an ascii image.

Borders come from "ui.helpers.ui-tokens.borderStyle"

*IMAGES MUST HAVE A CONSISTENT WIDTH!*

picture: (table)
?border_index: (number) pick a border
--]]
local function add_border_to_art(picture, border_index)
	-- Get border icons
	local border_table = require("ui.helpers.ui-tokens").borderStyle
	local border

	if border_index == nil then
		border = border_table[1]
	end

	local new_pic = {}
	local image_width = string.len(picture[1])

	for i, pic in ipairs(picture) do
		local new_line

		-- First line
		if i == 1 then
			new_line = border.top_left
			local line_i = 0

			while line_i < image_width do
				new_line = new_line .. border.top_center
				line_i = line_i + 1
			end

			new_line = new_line .. border.top_right
		-- Last line
		elseif next(picture, i) == nil then
			-- Add observing line first
			-- Necessary to get entire image
			local last_line = border.side_left .. pic .. border.side_right
			table.insert(new_pic, last_line)

			-- Add bottom border
			new_line = border.bottom_left
			local line_i = 0

			while line_i < image_width do
				new_line = new_line .. border.bottom_center
				line_i = line_i + 1
			end

			new_line = new_line .. border.bottom_right
		-- Part of Image
		else
			new_line = border.side_left .. pic .. border.side_right
		end

		-- Add to image
		table.insert(new_pic, new_line)
	end

	return new_pic
end

M.add_border_to_art = add_border_to_art

--[[
Add some bottom text to a picture.

Does not handle padding - adjust the `text_prefix` and `text_postfix`
arguments accordingly.

...Or just do it in the string, I don't care...

picture: (table)
text: (string)
?text_prefix: (string)
?text_postfix: (string)
--]]
local function add_text_to_bottom(picture, text, text_prefix, text_postfix)
	local new_pic = picture
	local prefix = ""
	local postfix = ""

	if text_prefix ~= nil then
		prefix = text_prefix
	end

	if text_postfix ~= nil then
		postfix = text_postfix
	end

	table.insert(new_pic, prefix .. text .. postfix)

	return new_pic
end

M.add_text_to_bottom = add_text_to_bottom

--[[ Puts a random ascii image and text on the dashboard --]]
-- FIXME: Indexing bug... idk where lol
function M.get_random_image()
	-- Set up
	math.randomseed(os.time())
	math.random()

	local art = require("ui.dashboard.ascii-art")

	local images = art.image_list
	local texts = art.text
	local logos = art.logo_list
	local fixes = art.fixes

	-- Initialize
	local img_table_size = 0
	local texts_table_size = 0
	local logo_table_size = 0
	local fixes_table_size = 0

	for _, _ in ipairs(images) do
		img_table_size = img_table_size + 1
	end

	for _, _ in ipairs(texts) do
		texts_table_size = texts_table_size + 1
	end

	for _, _ in ipairs(logos) do
		logo_table_size = logo_table_size + 1
	end

	for _, _ in ipairs(fixes) do
		fixes_table_size = fixes_table_size + 1
	end

	-- Get random number
	local number_img = math.random(img_table_size)
	local number_text = math.random(texts_table_size)
	local number_logo = math.random(logo_table_size)
	local number_fixes = math.random(fixes_table_size)

	-- Index ascii
	local img = images[number_img]
	local text = texts[number_text]
	local logo = logos[number_logo]
	local prefix = fixes[number_fixes].pre
	local postfix = fixes[number_fixes].post

	-- NOTE: Debug
	-- local img = images[1]
	-- local logo = logos[6]

	-- Nil Checks (bad programmer alert)
	if img == nil then
		img = {
			"       ",
			" OH NO ",
			"       ",
		}
	end
	if text == nil then
		text = "Oopie"
	end
	if logo == nil then
		logo = "Neovm"
	end
	if prefix == nil then
		prefix = "*F*"
	end
	if postfix == nil then
		postfix = "~?!"
	end

	return add_logo_to_art(logo, add_text_to_bottom(add_border_to_art(img), text, prefix, postfix))
end

return M
