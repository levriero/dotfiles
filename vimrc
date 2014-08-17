scriptencoding utf-8 " Set encoding to UTF-8
set encoding=utf-8   " Set encoding to UTF-8
set shell=/bin/sh    " Use sh for shell commands
set nocompatible     " Don't be backwards compatible with vi
filetype off         " Required for Vundle

" set the runtime path to include Vundle, and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'vim-ruby/vim-ruby'
Plugin 'chriskempson/base16-vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'thoughtbot/vim-rspec'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'

call vundle#end()         " Required for Vundle
filetype plugin indent on " Turn file type detection back on

" ===============================================================================
" General Settings
" ===============================================================================

syntax on                     " Enable syntax highlighting
colorscheme base16-ocean      " Set color scheme

set t_Co=256                  " Enable 256 color schemes
set background=dark           " Set dark background

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

set guioptions-=r             " Remove scrollbars
set guioptions-=L             " Remove scrollbars

" Set leader key to space
let mapleader="\<space>"

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
" Unite
" ===============================================================================

" Use ag for grep searching
if executable('ag')
  let g:unite_source_grep_command        = 'ag'
  let g:unite_source_grep_default_opts   = '-i --line-numbers --nocolor --nogroup --hidden --ignore ''.git'''
  let g:unite_source_grep_recursive_opt  = ''
  let g:unite_source_grep_max_candidates = 200
endif

" Ignore folders on file searching
call unite#custom#source('file, file_rec/async', 'ignore_pattern', '\.rsync_cache\|\.git\|\images\|\node_modules')

" Mappings
nnoremap <leader>p :Unite -start-insert file_rec/async <CR>
nnoremap <leader>b :Unite buffer<CR>
nnoremap <leader>f :Unite grep:.<CR>

" ===============================================================================
" Neocomplete
" ===============================================================================

let g:neocomplete#enable_at_startup                 = 1 " Enable neocomplete
let g:neocomplete#enable_smart_case                 = 1 " Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.

" Close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction

" Tab completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ===============================================================================
" Emmet-vim
" ===============================================================================

let g:user_emmet_install_global = 0       " Enable just for the given file types
let g:user_emmet_mode           = 'a'     " Enable all functions in all modes
let g:user_emmet_leader_key     = '<C-y>' " Trigger emmet (followed by comma)

autocmd FileType html,css,eruby,scss EmmetInstall " Only for frontend code

" ===============================================================================
" Vim-airline
" ===============================================================================

set laststatus=2
set noshowmode

let g:airline_powerline_fonts = 1

" ===============================================================================
" rspec.vim
" ===============================================================================

let g:rspec_runner = "os_x_iterm"

nnoremap <Leader>rc :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rn :call RunNearestSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>

" ===============================================================================
" Syntastic
" ===============================================================================

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" ===============================================================================
" netrw
" ===============================================================================

let g:netrw_list_hide= '.git'

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap / /\v
vnoremap / /\v
nnoremap H ^
nnoremap L $
nnoremap ; :
nnoremap : ;

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
