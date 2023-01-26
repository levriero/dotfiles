-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup({
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '▁' },
    topdelete    = { text = '▔' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },

  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    -- Navigation
    vim.keymap.set('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true , desc = 'Next Hunk' })

    vim.keymap.set('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true , desc = 'Prev Hunk' })

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', '[s]tage hunk')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', '[r]eset hunk')
    map('n', '<leader>hu', gs.undo_stage_hunk, '[u]ndo stage hunk')
    map('n', '<leader>hp', gs.preview_hunk, '[p]review hunk')
    map('n', '<leader>hS', gs.stage_buffer, '[S]tage buffer')
    map('n', '<leader>hR', gs.reset_buffer, '[R]eset buffer')
    map('n', '<leader>hb', function() gs.blame_line { full = true } end, '[b]lame line')
    map('n', '<leader>hd', gs.diffthis, '[d]iff this')
    map('n', '<leader>hD', function() gs.diffthis('~') end, '[D]iff this ~')
    -- map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
  end
})
