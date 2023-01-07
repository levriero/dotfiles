require('catppuccin').setup({
  integrations = {
    lsp_saga = true,
    mason = true,
    nvimtree = true,
    treesitter = true,
    telescope = true,
    cmp = true,
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
  }
})

-- setup must be called before loading
vim.cmd.colorscheme 'catppuccin-macchiato'
