require('lualine').setup {
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    globalstatus = true,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  disabled_filetypes = {
    statusline = {},
    winbar = {},
  },
  sections = {
    lualine_c = { {'filename', file_status = true, path = 1} },
    lualine_x = { {'filetype'}, {'encoding'} },
  },
}
