local navic = require('nvim-navic')

require('lualine').setup {
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    globalstatus = true,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  disabled_filetypes = {
    statusline = {},
    winbar = {},
  },
  sections = {
    lualine_c = {
      { 'filename', file_status = true, path = 1 }
    },
    lualine_x = { 'buffers' },
    lualine_y = { '' },
    lualine_z = { 'location' },
  },
  winbar = {
    lualine_c = { { navic.get_location, cond = navic.is_available } },
    lualine_x = { 'filetype' }
  },
  inactive_winbar = {
    lualine_c = { { navic.get_location, cond = navic.is_available } },
    lualine_x = { 'filetype' }
  }
}
