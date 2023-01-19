vim.g['test#strategy'] = 'toggleterm'

vim.keymap.set('n', '<leader>tn', vim.cmd.TestNearest)
vim.keymap.set('n', '<leader>tf', vim.cmd.TestFile)
vim.keymap.set('n', '<leader>ts', vim.cmd.TestSuite)
vim.keymap.set('n', '<leader>tl', vim.cmd.TestLast)
vim.keymap.set('n', '<leader>tv', vim.cmd.TestVisit)
