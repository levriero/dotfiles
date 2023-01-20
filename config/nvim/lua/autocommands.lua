-- toggle cusor line
local toggle_cursor_line_group = vim.api.nvim_create_augroup('ToggleCursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'WinLeave' }, {
  group = toggle_cursor_line_group,
  pattern = { '*' },
  callback = function (table)
    local event = table['event']

    if event == 'WinEnter' then
      vim.api.nvim_set_option_value('cursorline', true, { scope = 'local' })
    elseif event == 'WinLeave' then
      vim.api.nvim_set_option_value('cursorline', false, { scope = 'local' })
    end
  end
})

-- remove trailing whitespace
local remove_trailing_whitespace = vim.api.nvim_create_augroup('RemoveTrailingWhitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = remove_trailing_whitespace,
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
