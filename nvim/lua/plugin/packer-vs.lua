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
    -- Global
    ------------------------------
    use("chrisbra/unicode.vim") -- Unicode Search
    use("numToStr/Comment.nvim") -- Commenting

    -- -- Bootstrap
    -- if packer_bootsrap then
    --   require("packer").sync()
    -- end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
