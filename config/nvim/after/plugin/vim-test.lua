vim.g['test#strategy'] = 'toggleterm'

vim.keymap.set('n', '<leader>rc', vim.cmd.TestFile)
vim.keymap.set('n', '<leader>rn', vim.cmd.TestNearest)
vim.keymap.set('n', '<leader>rs', vim.cmd.TestSuite)
vim.keymap.set('n', '<leader>rl', vim.cmd.TestLast)
vim.keymap.set('n', '<leader>rv', vim.cmd.TestVisit)
