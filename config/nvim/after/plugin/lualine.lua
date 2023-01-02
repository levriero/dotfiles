local status, lualine = pcall(require, 'lualine')
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox'
  },
  sections = {
    lualine_a = {
      {
        'filename', 
        path = 1
      }
    },
    lualine_x = {'encoding', 'filetype'}
  }
}
