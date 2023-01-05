vim.cmd [[
  augroup toggle_cursorline
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
  augroup END
]]
