-- toggle cusor line
vim.api.nvim_create_autocmd({ 'WinEnter', 'WinLeave' }, {
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
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
