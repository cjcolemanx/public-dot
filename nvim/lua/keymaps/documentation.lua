local M = {}

local legend = {}

--[[
Adds a keybinding to the legend.

Used by "legendary.nvim" to display keybindings.

keys: (string) 
description: (string) 
description_per_mode?: (table) 
opts?: (table) options
modes?: (table: strings) Modes where keybind is in effect (default = Normal)
--]]
function M.add_to_legend(keys, description, description_per_mode, opts, modes)
	local map = { keys, description_per_mode, description = description, opts = opts, mode = modes }

	table.insert(legend, map)
end

--[[
For mapping simple Normal mode mappings

keys: (string)
description: (string)
--]]
function M.add_simple_to_legend(keys, description)
	M.add_to_legend(keys, description, nil, nil, nil)
end

--[[
For mapping keys that have per-mode differences.

Format:

{
  'keybind',
  {
    n = {
      description = 'Your description for Normal mode',
      opts = { ... },
    },
    v = {
      description = 'Your description for Visual mode',
      opts = { ... },
    },
  },
  description = 'Your broad description',
  opts = { opts }
}

keys: (string)
braod_description: (string)
mode_descriptions: (table)
--]]
function M.add_mode_dependent_to_legend(keys, broad_description, mode_descriptions)
	M.add_to_legend(keys, broad_description, mode_descriptions, nil, nil)
end

M.legend = legend

return M
