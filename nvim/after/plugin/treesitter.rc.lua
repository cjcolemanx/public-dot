local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  -- print("ERROR: plugin 'nvim-treesitter' is unavailable")
  return
end

ts.setup({
  auto_install = true,
  autotag = {
    enable = true,
  },
  ensure_installed = {
    -- "angular",
    "bash",
    "c_sharp",
    "css",
    "fish",
    -- "gdresource",
    "gdscript",
    "gitignore",
    "graphql",
    "help", -- vim help files
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "latex",
    "lua",
    "markdown",
    "php",
    "python",
    "regex",
    "rust",
    "sql",
    "scss",
    "sxhkdrc",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
    -- "swift",
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  matchup = {
    enable = true,
  },
  sync_install = true,
  textobjects = {
    enable = true,
    lookahead = true,
    -- TODO: Move to keymaps.plugin-keymaps
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["al"] = "@call.outer",
      ["il"] = "@call.inner",
      ["ap"] = "@parameter.outer",
      ["ip"] = "@parameter.inner",
      ["ao"] = "@condition.outer",
      ["io"] = "@condition.inner",
      ["as"] = "@statement.outer",
    },
  },
  -- Nvim-TS-Rainbow
  rainbow = {
    enable = true,
    disable = {}, -- list of languages to disable highlighting for
    extendend_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table
    max_file_lines = nil, -- Do not enable for files with more than n lines
    -- colors = {},
    -- termcolors = {},
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
