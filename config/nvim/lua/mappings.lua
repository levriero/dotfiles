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


-- No-op for space in normal/visual as it's used as leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Evenly distribute windows
keymap.set('n', '<leader>=', ':wincmd =<CR>')

-- Maximize focus window
keymap.set('n', '<leader>-', ':wincmd _<CR>:wincmd |<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
