# General

"kyazdani42/nvim-tree.lua", -- File Tree
deps:  
  "kyazdani42/nvim-web-devicons", -- File Icons

"nvim-telescope/telescope.nvim", -- Search Interface
deps:
  "nvim-lua/popup.nvim", -- Pop-Up Windows
  "nvim-lua/plenary.nvim", -- Utilities
  "nvim-telescope/telescope-file-browser.nvim", -- File Browser
  "nvim-telescope/telescope-frecency.nvim", -- Frequent + Recent
  "nvim-telescope/telescope-ui-select.nvim", -- TScope Native Selection

use("chrisbra/unicode.vim") -- Unicode Search
use("numToStr/Comment.nvim") -- Commenting
use("folke/zen-mode.nvim") -- Minimalism

## UI

`stevearc/dressing.nvim`, -- Better NeoVim UI
deps: 
  `nvim-lua/plenary.nvim`
  
## Palettes

"folke/tokyonight.nvim" -- Tokyo Night
"EdenEast/nightfox.nvim" -- Nightfox
"sainnhe/gruvbox-material" -- Gruvbox Material
"svrana/neosolarized.nvim" -- NeoSolarized
"arzg/vim-substrata" -- Substrata
"jacoborus/tender.vim" -- Tender
"rktjmp/lush.nvim" -- Lush

# Base / Dev config

-- LSP server mgmt
"williamboman/mason.nvim",
"williamboman/mason-lspconfig.nvim",

-- LSP
"neovim/nvim-lspconfig",

-- completion
"hrsh7th/cmp-nvim-lsp",
"hrsh7th/cmp-buffer",
"hrsh7th/cmp-path",
"hrsh7th/cmp-cmdline",
"hrsh7th/nvim-cmp",
"dmitmel/cmp-digraphs",
-- "tamago324/cmp-zsh",
"David-Kunz/cmp-npm", -- npm dependencies
"chrisgrieser/cmp-nerdfont", -- NF icons
"hrsh7th/cmp-nvim-lua", -- for configs
"KadoBOT/cmp-plugins", -- for plugins
-- "pontusk/cmp-vimwiki-tags"

-- treesitter

-- linter and formatter
"jose-elias-alvarez/null-ls.nvim",

-- Snippets
"L3MON4D3/LuaSnip"
"saadparwaiz1/cmp_luasnip",

-- better autocomplete menu (icons!)
"onsails/lspkind.nvim",

-- LSP gui enhancements
"glepnir/lspsaga.nvim",
"folke/trouble.nvim",

-- diagnostic view
"nvim-treesitter/nvim-treesitter",
"nvim-treesitter/nvim-treesitter-textobjects",
"windwp/nvim-ts-autotag",

-- debugger
-- 'mfussenegger/nvim-dap',
-- 'rcarriga/nvim-dap-ui',
-- 'simrat39/symbols-outline.nvim',
-- 'j-hi/fidget.nvim'

-- refactoring
"ThePrimeagen/refactoring.nvim",

# VSCode

chrisbra/unicode.vim
numToStr/Comment.nvim
