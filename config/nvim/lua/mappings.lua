local keymap = vim.keymap

-- Enter command mode with :
keymap.set('n', ';', ':')
keymap.set('n', ':', ';')

-- Vertical buffer split
keymap.set('n', '<leader>v', '<C-w>v<C-w>l', { desc = '[v]ertical buffer split' })

-- Horizontal buffer split
-- keymap.set('n', '<leader>h', '<C-w>s<C-w>j', { desc = '[h]orizontal buffer split' })

-- Copy file path to clipboard
keymap.set('n', '<leader>cp', ':let @+ = expand("%:p")<cr>', { desc = '[C]opy file [P]ath' })

-- Navigate buffers with tab
keymap.set('n', '<tab>', '<C-w>w')
keymap.set('n', '<S-tab>', '<C-w>W')

-- No-op for space in normal/visual as it's used as leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Evenly distribute windows
keymap.set('n', '<leader>=', ':wincmd =<CR>', { desc = 'Make all windows (almost) equally high and wide' })

-- Maximize focus window
keymap.set('n', '<leader>-', ':wincmd _<CR>:wincmd |<CR>', { desc = 'Maximize current window' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
