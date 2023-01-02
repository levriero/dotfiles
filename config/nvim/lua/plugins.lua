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
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use { 'ellisonleao/gruvbox.nvim', as = 'gruvbox' }

  -- file explorer
  use 'nvim-tree/nvim-tree.lua'

  -- file icons (for nvim-tree, lualine, etc.)
  use 'nvim-tree/nvim-web-devicons'

  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- syntax highlighting 
  use 'nvim-treesitter/nvim-treesitter'

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
