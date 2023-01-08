local fn = vim.fn
local cmd = vim.cmd
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  cmd([[packadd packer.nvim]])
end

packer = require("packer")

packer.init({
  opt_default = false,
  display = {
    working_sym = " ⚒ ",
    error_sym = " 💣 ",
    done_sym = " ✓ ",
    removed_sym = " 🔥 ",
    moved_sym = " 🚀 ",
    header_sym = " _ ",
    prompt_border = "double",
  },
})

return packer.startup({
  function(use)
    use("wbthomason/packer.nvim") -- Self-Managing

    ------------------------------
    -- => Global
    ------------------------------
    use({
      "nvim-tree/nvim-tree.lua", -- File Tree
      requires = {
        "nvim-tree/nvim-web-devicons", -- File Icons
      },
    })
    use("lukas-reineke/indent-blankline.nvim")
    use({
      "nvim-telescope/telescope.nvim", -- Search Interface
      requires = {
        "nvim-lua/popup.nvim", -- Pop-Up Windows
        "nvim-lua/plenary.nvim", -- Utilities
        "nvim-telescope/telescope-file-browser.nvim", -- File Browser
        "nvim-telescope/telescope-frecency.nvim", -- Frequent + Recent
        "nvim-telescope/telescope-ui-select.nvim", -- TScope Native Selection
      },
    })
    use("chrisbra/unicode.vim") -- Unicode Search
    use("numToStr/Comment.nvim") -- Commenting
    use("windwp/nvim-autopairs") -- Auto Closing
    use("folke/zen-mode.nvim") -- Minimalism
    use("folke/todo-comments.nvim") -- TODO Highlights
    use("kylechui/nvim-surround") -- Surround
    use("abecodes/tabout.nvim") -- <Tab> out of quotes and braces
    use({
      "ggandor/leap.nvim",
      requires = { "tpope/vim-repeat" }, -- needed for dot (.) repetition
    }) -- 'Sneak'-like motion plugin

    -- NOTE: not using these atm
    -- use("beauwilliams/focus.nvim") -- Better Splits

    -- NOTE: May want to make a dynamic load
    -- it also increases launch time by, like, a lot...
    -- use("vimwiki/vimwiki")

    ------------------------------
    -- => Telescope
    ------------------------------

    use("nvim-telescope/telescope-project.nvim") -- Projects in NVIM
    use("nvim-telescope/telescope-symbols.nvim")
    use("pwntester/octo.nvim") -- View GitHub Issues and PRs from Telescope

    -- NOTE: may break:
    -- Uses Uberzug, so it may not work right off.
    use("nvim-telescope/telescope-media-files.nvim") -- File Previewer

    -- NOTE: not using these atm
    -- use("HUAHUAI23/telescope-session.nvim") -- Nvim Session MGMT (less good than telescope-project)
    -- use("benfowlwer/telescope-luasnip.nvim") -- See snippets
    -- use("nvim-telescope/telescope-ghq.nvim") -- GHQ viewing + integration?
    -- use("LukasPietzschmann/telescope-tabs") -- See tabs

    ------------------------------
    -- => User Interface
    ------------------------------
    use({
      "stevearc/dressing.nvim", -- Better NeoVim UI
      requires = { "nvim-lua/plenary.nvim" },
    })
    use("nvim-lualine/lualine.nvim") -- Powerline (for NeoVim :])
    use("nanozuki/tabby.nvim") -- Powerline-ish Tabs
    use("psliwka/vim-smoothie") -- Smooth Scrolling
    use("rcarriga/nvim-notify") -- notifications in neovim
    use("Pocco81/high-str.nvim") -- Highlight text in a buffer
    use("norcalli/nvim-colorizer.lua") -- In-buffer color highlighter

    -- NOTE: ehhhhhh
    use("nvim-zh/colorful-winsep.nvim") -- colorize window separators

    -------------------------
    -- => LSP
    -------------------------
    use("folke/neodev.nvim") -- NeoVim-focused hoverdoc support

    ------------------------------
    -- => Palettes
    ------------------------------
    use("folke/tokyonight.nvim") -- Tokyo Night
    use("EdenEast/nightfox.nvim") -- Nightfox
    use("sainnhe/gruvbox-material") -- Gruvbox Material
    use("svrana/neosolarized.nvim") -- NeoSolarized
    use("arzg/vim-substrata") -- Substrata
    use("jacoborus/tender.vim") -- Tender
    use("rktjmp/lush.nvim") -- Lush
    use("RRethy/nvim-base16") -- Base16 scheme colleaction

    ------------------------------
    -- => Other
    ------------------------------
    use("kovetskiy/sxhkd-vim") -- sxhkd syntax highlighting
    use("p00f/nvim-ts-rainbow") -- rainbow parenthesis
    use("elkowar/yuck.vim") -- eww syntax highlighting

    ------------------------------
    -- => NeoVim Development
    ------------------------------
    use("tjdevries/vlog.nvim") -- Better Logging
    use("MunifTanjim/nui.nvim") -- UI Components

    -------------------------
    -- => Etc.
    -------------------------

    -- FIXME: new plugins (may remove)
    use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
    use("xiyaowong/link-visitor.nvim")
    use("glepnir/dashboard-nvim")
    use("sunjon/Shade.nvim")
    use("j-hui/fidget.nvim")
    use("mrjones2014/legendary.nvim")

    -- NOTE: I'm only using this so that my dream of a hot-reloading dashboard image becomes a ~reality~
    use("miversen33/import.nvim")

    -- NOTE: Doesn't work w/ config lol
    -- use("folke/drop.nvim")

    -- TODO: Try these out
    -- use("jreybert/vimagit") -- enhanced git workflow in vim
    use("folke/which-key.nvim") -- Document your keymaps!
    -- use("yamatsum/nvim-cursorline") -- highlight instances of word under line or cursor
    -- use("xiyaowong/nvim-cursorword") -- half of nvim-cursorline
    -- use("ziontee113/icon-picker.nvim")
    -- use("michaelb/sniprun") -- run code snippets in a terminal
    -- use("ray-x/navigator.lua") -- LSPSaga alternative
    -- use("cbochs/grapple.nvim") -- Tag and jump important files
    -- use("ellisonleao/glow.nvim") -- Markdown preview (depends on Glow)

    -------------------------
    -- => Setup
    -------------------------

    -- Dynamic Load
    config = require("plugin.configs")
    for key, value in pairs(config) do
      for _k, _v in pairs(value) do
        use(_v)
      end
    end

    -- Bootstrap
    if packer_bootstrap then
      require("packer").sync()
    end
  end,

  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
