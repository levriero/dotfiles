-- disable netrw 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require('nvim-tree').setup({
  open_on_setup = true,
  view = {
    width = 35
  },
})

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFindFileToggle)
