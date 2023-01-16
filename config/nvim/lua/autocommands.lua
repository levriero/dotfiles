-- toggle cusor line
vim.api.nvim_create_autocmd({ 'WinEnter', 'WinLeave' }, {
  pattern = { '*' },
  callback = function (ev)
    if ev == 'WinEnter' then
      vim.api.nvim_set_option_value('cursorline', '', 'local')
    elseif ev == 'WinLeave' then
      vim.api.nvim_set_option_value('nocursorline', '', 'local')
    end
  end
})

-- remove trailing whitespace
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
