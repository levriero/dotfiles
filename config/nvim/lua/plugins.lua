local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- file explorer
  use 'nvim-tree/nvim-tree.lua'

  -- file icons (for nvim-tree, lualine, etc.)
  use 'nvim-tree/nvim-web-devicons'

  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- "gc" to comment visual regions / lines
  use 'numToStr/Comment.nvim'

  -- highlight, edit, and navigate code
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- additional text objects via treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Add "end" to certain structures wisely
  use 'RRethy/nvim-treesitter-endwise'

  -- LSP Configuration & Plugins
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- useful status updates for LSP
      'j-hui/fidget.nvim',

      -- additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  -- fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- fuzzy Finder Algorithm which requires local dependencies to be built.
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-sleuth'

  -- undo tree visualizer
  use 'mbbill/undotree'

  -- Clear search highlight when cursor is moved
  use 'junegunn/vim-slash'

  -- Persist and toggle multiple terminals
  use { 'akinsho/toggleterm.nvim', tag = '2.*' }

  -- running tests on different granularities
  use 'vim-test/vim-test'
  --
  -- -- lsp plugin
  -- use { 'glepnir/lspsaga.nvim', branch = 'main' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
