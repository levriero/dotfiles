require('toggleterm').setup({
  open_mapping = [[<c-t>]],
  direction = 'float',
})

-- toggle lazygit in a new floating terminal
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

vim.keymap.set('n', '<leader>g', function ()
  lazygit:toggle()
end, { silent = true })
