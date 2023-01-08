local status, cmp = pcall(require, "cmp")
local status_luasnip, luasnip = pcall(require, "luasnip")

if not status then
  -- print("ERROR: plugin 'CMP' is unavailable")
  return
end
if not status_luasnip then
  -- print("ERROR: plugin 'luasnip' is unavailable")
  return
end

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "ﬦ",
  -- TypeParameter = ""
  TypeParameter = "",
}

if cmp then
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    -- disable completion in comments FIXME
    enabled = function()
      local context = require("cmp.config.context")
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -5,
        side_padding = 0,
        scroll_off = 7,
      },
      documentation = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      },
    },
    experimental = {
      ghost_text = true,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },

      -- VSCode like
      -- format = function(entry, vim_item)
      --   local kind = require("lspkind").cmp_format({
      --     mode = "symbol_text",
      --     maxwidth = 50 ,
      --     menu = ({
      --       buffer = "[Buffer]",
      --       nvim_lsp = "[LSP]",
      --       luasnip = "[LuaSnip]",
      --     }),
      --   })(entry, vim_item)
      --   -- local strings = vim.split(kind.kind, "%s", { trimempty = true })
      --   -- kind.kind = " " .. strings[1] .. " "
      --   -- kind.menu = "    (" .. strings[2] ..
      --
      --   return kind
      -- end,
      format = function(entry, item)
        if entry.source.name == "cmdline" then
          item.kind = ""
          item.menu = "Vim"
          return item
        end
        item.menu = item.kind
        item.kind = kind_icons[item.kind]
        return item
      end,
    },
    mapping = require("keymaps.plugin-maps").cmp(cmp, luasnip),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "path" },
      { name = "luasnip", priority = 40, option = { show_autosnippets = false } },
      { name = "nvim_lsp_signature_helper" },
      { name = "nvim_lsp_document_symbol" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "emmet_ls" },
    },
    view = {
      entries = { name = "custom", selection_order = "near_cursor" },
    },
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "path" },
      { name = "cmdline" },
    },
  })
end
