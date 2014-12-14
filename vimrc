" Set encoding to UTF-8
scriptencoding utf-8
set encoding=utf-8

" Use sh for shell commands
set shell=/bin/sh

" Don't be backwards compatible with vi
set nocompatible

" Required for Vundle
filetype off

" Set the runtime path to include Vundle, and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


call vundle#end()         " Required for Vundle
filetype plugin indent on " Turn file type detection back on

" ===============================================================================
" General Settings
" ===============================================================================

syntax enable                 " Enable syntax highlighting

set t_Co=256                  " Enable 256 color schemes
set background=light          " Set light background

set ttyfast                   " Notify of running fast terminal, improves redrawing
set lazyredraw                " Don't redraw when running macros

set number                    " Enable line numbers
set autoindent                " Enable autoindent
set showmatch                 " Show bracket matches

set autoread                  " Enable auto-reading of files if they have been changed from the outside
set autowriteall              " Save on buffer switch

set nobackup                  " Disable backup files
set noswapfile                " Disable swap files

set hidden                    " Hide buffers instead of closing them
set splitright                " Split new buffers to the right

set showcmd                   " Display incomplete commands
set wildmenu                  " Enhance command line completion

set hlsearch                  " Hightlight search matches
set incsearch                 " Incremental search
set ignorecase                " Case-insensitive searching
set smartcase                 " Use case-sensitive searching if expression contains capital letter

set gdefault                  " Apply global substitutions by default

set list                      " Hightlight whitespace characters
set listchars=tab:▸\ ,trail:· " Customize whitespace characters shown

set expandtab                 " Use spaces not tabs
set tabstop=2                 " Set indentation to 2 spaces
set shiftwidth=2              " Set indentation to 2 spaces

set mouse=a                   " Enable mouse support for all modes
set clipboard=unnamed         " Use system clipboard

set noerrorbells              " Disable error bells
set novisualbell              " Disable error flashing

" Set leader key to space
let mapleader="\<space>"

"
" ===============================================================================
" Autocommand
" ===============================================================================

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces() " Remove trailing whitespaces automatically when a file is saved
autocmd FileType markdown,text setlocal spell               " Enable spell check for text files

" Only show cursorline in the current window and in normal mode
augroup cline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

" ===============================================================================
" netrw
" ===============================================================================

let g:netrw_list_hide= '.git,.DS_Store'

" ===============================================================================
" Mappings
" ===============================================================================

nnoremap <leader><space> :noh<CR>
nnoremap <leader>e :Ex<CR>
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap / /\v
vnoremap / /\v
nnoremap H ^
nnoremap L $
nnoremap ; :
nnoremap : ;

" ===============================================================================
" Abbreviations
" ===============================================================================

autocmd FileType javascript :iabbrev <buffer> iif (function() {
      \<CR>'use strict';
      \<CR>
      \<CR>})();<ESC><s-O>

autocmd FileType javascript :iabbrev <buffer> jdes describe('', function() {
      \<CR>it('should ', function() {
      \<CR>});
      \<CR>});<ESC><up><s-O>

" ===============================================================================
" Functions
" ===============================================================================

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
