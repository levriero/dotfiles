require('rose-pine').setup({
  --- @usage 'main' | 'moon'
	dark_variant = 'moon',
  disable_italics = true,
})

-- set colorscheme after options
vim.cmd('colorscheme rose-pine')

local utils = {}

function utils.define_autogroups(definitions)
  for group_name, definition in pairs(definitions) do
    for _, def in pairs(definition) do
    end
  end
end

return utils
