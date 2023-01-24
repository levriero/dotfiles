local U = require "catppuccin.utils.colors"

require('catppuccin').setup({
  transparent_background = true,
  custom_highlights = function (colors)
    return {
      CursorLine = {
        bg = U.vary_color({ latte = U.lighten(colors.mantle, 0.70, C.base) }, U.darken(colors.surface0, 0.64, colors.base)),
      },
    }
  end,
  integrations = {
    cmp = true,
    fidget = true,
    gitsigns = true,
    mason = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    navic = {
      enabled = true,
      custom_bg = 'NONE'
    },
  }
})

-- setup must be called before loading
vim.cmd.colorscheme 'catppuccin-macchiato'
