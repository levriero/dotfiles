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

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" UI
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'itchyny/lightline.vim'

" Misc
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'

" Editing
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'

" tmux
Plugin 'tpope/vim-dispatch'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'

" Languages
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-rails'

call vundle#end()         " Required for Vundle
filetype plugin indent on " Turn file type detection back on

" ===============================================================================
" General Settings
" ===============================================================================

" Enable syntax highlighting
syntax enable

" Set colorscheme
set t_Co=256
set background=dark
colorscheme seoul256

set ttyfast                   " Notify of running fast terminal, improves redrawing
set lazyredraw                " Don't redraw when running macros
set synmaxcol=128             " Maximum column number to highlight

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

set clipboard=unnamed         " Use system clipboard

set noerrorbells              " Disable error bells
set novisualbell              " Disable error flashing

set laststatus=2              " Display status var
set noshowmode                " Don't show default vim mode information

" Set leader key to space
let mapleader="\<space>"

" ===============================================================================
" Autocommand
" ===============================================================================

" Remove trailing whitespaces automatically when a file is saved
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Enable spell check for text files
autocmd FileType markdown,text setlocal spell

" Save on buffer focus lost
augroup AutoWrite
  autocmd! BufLeave * :update
augroup END

" ===============================================================================
" netrw
" ===============================================================================

let g:netrw_list_hide= '.git,.DS_Store,.sass-cache'

" ===============================================================================
" lightline
" ===============================================================================

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'fileformat': 'LightlineFileFormat',
      \   'fileencoding': 'LightlineFileEncoding',
      \ }
      \ }

function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightlineFileFormat()
  return ''
endfunction

function! LightlineFileEncoding()
  return ''
endfunction

" ===============================================================================
" Unite
" ===============================================================================

" Use ag for grep searching
let g:unite_source_grep_command        = 'ag'
let g:unite_source_grep_default_opts   = '-i --line-numbers --nocolor --nogroup --hidden --ignore ''.git'''
let g:unite_source_grep_recursive_opt  = ''

" Ignore folders on file searching
call unite#custom#source('file, file_rec/async', 'ignore_pattern', join([
  \ '\.git/',
  \ '\.tmp/',
  \ 'tmp',
  \ 'node_modules',
  \ 'coverage',
  \ 'images',
  \ 'fonts',
  \ 'bower_components',
  \ '.sass-cache',
  \ '.pdf',
  \ ], '\|'))

nnoremap <leader>p :Unite -start-insert file_rec/async<CR>
nnoremap <leader>b :Unite buffer<CR>
nnoremap <leader>f :Unite grep:.<CR>

" ===============================================================================
" Mappings
" ===============================================================================

nnoremap <leader><space> :noh<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap / /\v
vnoremap / /\v
nnoremap \ :Ag<SPACE>
nnoremap H ^
nnoremap L $
nnoremap ; :
nnoremap : ;
nnoremap <Leader>rc :w<CR> :call RunCurrentTestFile()<CR>
nnoremap <Leader>rn :w<CR> :call RunNearestTest()<CR>
nnoremap <Leader>ra :w<CR> :call RunAllTests()<CR>

function! RunCurrentTestFile()
  let command = "rspec " . @%
  VimuxRunCommand(command)
endfunction

function! RunNearestTest()
  let command = "rspec " . @% . ":" . line(".")
  VimuxRunCommand(command)
endfunction

function! RunAllTests()
  let command = "rspec spec"
  VimuxRunCommand(command)
endfunction

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
