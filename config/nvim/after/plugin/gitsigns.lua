require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    -- map({'n', 'v'}, '<leader>ts', ':Gitsigns stage_hunk<CR>')
    -- map({'n', 'v'}, '<leader>tr', ':Gitsigns reset_hunk<CR>')
    -- map('n', '<leader>tS', gs.stage_buffer)
    -- map('n', '<leader>tu', gs.undo_stage_hunk)
    -- map('n', '<leader>tR', gs.reset_buffer)
    -- map('n', '<leader>tp', gs.preview_hunk)
    map('n', '<leader>tb', function() gs.blame_line{full=true} end)
    -- map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>td', gs.diffthis)
    map('n', '<leader>tD', function() gs.diffthis('~') end)
    -- map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})
