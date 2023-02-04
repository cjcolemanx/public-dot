local status, neodev = pcall(require, "neodev")

if not status then
  return
end

neodev.setup({
  library = { plugins = { "neotest", "telescope.nvim", "nvim-treesitter", "plenary.nvim" }, types = true },
})
