local keymap = vim.keymap

-- Enter command mode with :
keymap.set('n', ';', ':')
keymap.set('n', ':', ';')

-- Vertical buffer split
keymap.set('n', '<leader>v', '<C-w>v<C-w>l')

-- Horizontal buffer split
keymap.set('n', '<leader>h', '<C-w>s<C-w>j')

-- Output file path
keymap.set('n', '<leader>w', ':echo @%<cr>')

-- Copy `pwd` to clipboard
keymap.set('n', '<leader>cp', ':let @+ = expand("%:p")<cr>', { silent = true })

-- Navigate buffers with tab
keymap.set('n', '<tab>', '<C-w>w')
keymap.set('n', '<S-tab>', '<C-w>W')

-- Move highlighted blocks up/down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- delete highlighted word into the void register
keymap.set('x', '<leader>p', "\"_dP")

keymap.set('n', 'Q', '<nop>')
