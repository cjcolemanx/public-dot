-- print("Loaded base plugins.")

return {

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
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lsp-document-symbol",
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
	{ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" },
	"saadparwaiz1/cmp_luasnip",

	-- better autocomplete menu (icons!)
	"onsails/lspkind.nvim",

	-- LSP gui enhancements
	"glepnir/lspsaga.nvim",
	"folke/trouble.nvim",

	-- diagnostic view
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/playground",
	"windwp/nvim-ts-autotag",
	"JoosepAlviste/nvim-ts-context-commentstring", -- commentstring TO in embeddeded languages (like Vue, React)

	-- debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"mxsdev/nvim-dap-vscode-js",
	{ "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile" },
	-- 'simrat39/symbols-outline.nvim',

	-- refactoring
	"ThePrimeagen/refactoring.nvim",

	-- Testing
	"nvim-neotest/neotest",
	-- NeoTest Plugins
	"nvim-neotest/neotest-python",
	"nvim-neotest/neotest-vim-test",
	"Issafalcon/neotest-dotnet", -- Still a wip, so may not completely work (looks good enough rn)
	"nvim-neotest/neotest-plenary",
	"haydenmeade/neotest-jest",
	"nvim-neotest/neotest-go",
	"MrcJkb/neotest-haskell",
	"rouge8/neotest-rust",
}
