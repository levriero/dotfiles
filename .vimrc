set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-ruby/vim-ruby'
Plugin 'chriskempson/base16-vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ===============================================================================
" General Settings
" ===============================================================================

scriptencoding utf-8
set encoding=utf-8

syntax on                    " Enable syntax highlighting
set number                   " Enable line numbers
set autoread                 " Enable auto-reading of files if they have been changed from the outside
set autowrite                " Save on buffer switch
set backup                   " Enable creation of backup files
set backupdir=~/.vim/backup  " Specify backup directory
set directory=~/.vim/tmp     " Specify temporary swap files directory
set splitright               " Split new buffers to the right and bottom
set splitbelow
set showcmd                  " Display incomplete commands
set hlsearch                 " Hightlight search matches
set list                     " Hightlight whitespace characters

" Set color scheme
set background=dark
colorscheme base16-ocean

" Soft tab indentation with 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" Customize whitespace characters shown
set listchars=tab:▸\ ,trail:·

" Set GUI font
if has('gui_running')
  set guifont=Source_Code_Pro:h16
endif


" Remove trailing whitespaces automatically when a file is saved
if has('autocmd')
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
endif


" Ignore folders for unite
call unite#custom#source('file, file_rec/async', 'ignore_pattern', '\.rsync_cache')


" ===============================================================================
" Mappings
" ===============================================================================

nnoremap <C-p> :Unite file_rec/async<CR>


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
