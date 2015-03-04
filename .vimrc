" Set encoding to UTF-8
scriptencoding utf-8
set encoding=utf-8

" Use sh for shell commands
set shell=/bin/sh

" Don't be backwards compatible with vi
set nocompatible

call plug#begin('~/.vim/plugged')

" UI
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'

" Misc
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-gtfo'
Plug 'mhinz/vim-signify'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'

" Languages
Plug 'tpope/vim-fireplace',        { 'for': 'clojure' }
Plug 'guns/vim-clojure-static',    { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'thoughtbot/vim-rspec'

call plug#end()

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

" Show (relative) line numbers
set number
set relativenumber

set autoindent                " Enable autoindent
set showmatch                 " Show bracket matches

" Enable auto-reading of files if they have been changed from the outside
set autoread

" Save on 'focus' switch
set autowrite
set autowriteall

" Sane backspacing
set backspace=indent,eol,start

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

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ===============================================================================
" Autocommand
" ===============================================================================

" Remove trailing whitespaces automatically when a file is saved
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Enable spell check and line wrapping for text files
autocmd FileType markdown,text setlocal spell wrap linebreak nolist

" Save on buffer focus lost
augroup AutoWrite
  autocmd! BufLeave * :update
augroup END

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" ===============================================================================
" netrw
" ===============================================================================

let g:netrw_list_hide= '.git,.DS_Store,.sass-cache'

" ===============================================================================
" syntastic
" ===============================================================================

let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_ruby_checkers = ['rubocop', 'mri']

" ===============================================================================
" vim-signify
" ===============================================================================
let g:signify_vcs_list = ['git']

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
" vim-rspec
" ===============================================================================

let g:rspec_command = "call VtrSendCommand('bundle exec rspec {spec}')"

nnoremap <Leader>rc :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rn :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>


" ===============================================================================
" VimTmuxRunner
" ===============================================================================

nnoremap <leader>ta :VtrAttachToPane<cr>
nnoremap <leader>to :VtrOpenRunner {'orientation': 'v', 'percentage': 20}<cr>
nnoremap <leader>tl :VtrSendLinesToRunner<cr>
vnoremap <leader>tl :VtrSendLinesToRunner<cr>

" ===============================================================================
" Mappings
" ===============================================================================

nnoremap <leader><space> :noh<CR>
nnoremap <leader>e :Explore<CR>
nnoremap j gj
nnoremap k gk
inoremap jk <ESC>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap / /\v
vnoremap / /\v
nnoremap H ^
nnoremap L $
nnoremap ; :
nnoremap : ;

" create a new file in the open buffer dir
nnoremap <Leader>n :e %:h/

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

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
