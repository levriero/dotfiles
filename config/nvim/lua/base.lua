local opt = vim.opt

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

vim.g.python3_host_prog = '$HOMEBREW_PREFIX/bin/python3'
vim.g.loaded_perl_provider = 0

-- Leader as space
vim.g.mapleader = [[ ]]

-- Use macOS system clipboard
if vim.fn.has 'macunix' then
  opt.clipboard:append { 'unnamedplus' }
end

-- Settings
opt.guicursor = ''

opt.nu = true
opt.relativenumber = true

opt.autoindent = true
opt.smartindent = true

opt.showcmd = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 50

opt.signcolumn = 'yes'

-- opt.colorcolumn = '80'
