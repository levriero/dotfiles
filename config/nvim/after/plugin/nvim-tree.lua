-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  open_on_setup = false,
  update_focused_file = {
    enable = true
  },
  view = {
    width = 30
  },
})

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFindFileToggle)
