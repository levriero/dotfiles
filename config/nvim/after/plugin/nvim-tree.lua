-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  open_on_setup = false,
  view = {
    width = 35
  },
})

-- vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFindFileToggle)
