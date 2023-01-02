local opt = vim.opt

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

vim.g.python3_host_prog = '$HOMEBREW_PREFIX/bin/python3'
vim.g.loaded_perl_provider = 0

-- Leader as space
vim.g.mapleader = [[ ]]

vim.wo.number = true

-- Use macOS system clipboard
if vim.fn.has "macunix" then
  opt.clipboard:append { 'unnamedplus' }
end

-- Settings
opt.autoindent = true
opt.smartindent = true
opt.hlsearch = true
opt.backup = false
opt.showcmd = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
