local status, lspsaga = pcall(require, "lspsaga")

if not status then
  print("ERROR: plugin 'lspsaga' is unavailable")
  return
end

lspsaga.init_lsp_saga({
  -- move_in_saga = { prev = "<C-p>", next = "<C-n>" },
  move_in_saga = { prev = "k", next = "j" },
  diagnostic_header = { " ", " ", " ", " " },
  scroll_in_preview = {
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
  code_action_icon = "ﯦ ",
  code_action_lightbulb = {
    sign = false,
    virtual_text = true,
  },
  finder_icons = {
    def = "  ",
    ref = "  ",
    link = "  ",
  },
  finder_action_keys = {
    open = "<CR>",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>", -- quit can be a table
  },
  server_filetype_map = {
    tsserver = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    sumneko_lua = { "lua" },
  },
})
