local status, lualine = pcall(require, 'lualine')
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    --- @usage 'rose-pine' | 'rose-pine-alt'
    theme = 'rose-pine'
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
