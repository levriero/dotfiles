vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- use homebrew python installation
vim.g.python3_host_prog = '$HOMEBREW_PREFIX/bin/python3'

-- do not load perl provider
vim.g.loaded_perl_provider = 0

-- leader as space
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

-- use macOS system clipboard
if vim.fn.has 'macunix' then
 local opt = vim.opt
  opt.clipboard:append { 'unnamedplus' }
end

vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- relative line numbers
vim.wo.number = true
vim.o.relativenumber = true

-- enable mouse mode
vim.o.mouse = 'a'

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.showcmd = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.swapfile = false
vim.o.backup = false

-- save undo history
-- vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
-- vim.o.undofile = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true

-- case insensitive search unless capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 50

vim.o.signcolumn = 'yes'

vim.o.cursorline = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Enable break indent
vim.o.breakindent = true

-- Timeout on command composition
vim.o.timeout = true
vim.o.timeoutlen = 500
