local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local cmd = vim.cmd
local o = vim.o

local base16_status, base16_schemes = pcall(require, "ui.look.base16-colors")

if not base16_status then
	print("ERROR: base16 color module not found")
end

-- Dark Background
o.background = "dark"

local ENV = vim.g.startenv

local useBase16 = false

-- Set Color Scheme
autocmd("VimEnter", {
	group = augroup("StartUp", { clear = true }),
	once = true,
	callback = function()
		if ENV == "journal" then
			cmd([[colorscheme tokyonight]])
		-- cmd([[colorscheme gruvbox-material]])
		elseif useBase16 then
			base16_schemes.applyBase16()
		else
			-- cmd([[colorscheme terafox]])
			cmd([[colorscheme duskfox]])
			-- cmd([[colorscheme tokyonight]])
			-- cmd([[colorscheme gruvbox-material]])
			-- cmd([[colorscheme carbonfox]])
			-- cmd([[colorscheme nightfox]])
			-- cmd([[colorscheme dayfox]])
			-- cmd([[colorscheme dawnfox]])
			-- cmd([[colorscheme nordfox]])
			-- cmd([[colorscheme neosolarized]]) -- Not working???
			-- cmd([[colorscheme substrata]])
			-- cmd([[colorscheme tender]])
			-- cmd([[colorscheme tender]])
		end
	end,
})
