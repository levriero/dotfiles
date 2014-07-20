scriptencoding utf-8 " Set encoding to UTF-8
set encoding=utf-8
set shell=/bin/sh    " Use shell for commands - For fish, as it is a non POSIX shell
set nocompatible     " Don't be compatible with vi
filetype off         " Required for Vundle

" set the runtime path to include Vundle and initialize
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

call vundle#end()         " Required for Vundle
filetype plugin indent on " Enable back filetype plugins

" ===============================================================================
" General Settings
" ===============================================================================

syntax on                                     " Enable syntax highlighting
set autoindent                                " Enable autoindent
set showmatch                                 " Show bracket matches
set number                                    " Enable line numbers
set autoread                                  " Enable auto-reading of files if they have been changed from the outside
set autowriteall                              " Save on buffer switch
set nobackup                                  " Disable backup files
set noswapfile                                " Disable swap files
set splitright                                " Split new buffers to the right
set showcmd                                   " Display incomplete commands
set hidden                                    " Hides buffers instead of closing them
set hlsearch                                  " Hightlight search matches
set incsearch                                 " Incremental search
set ignorecase                                " Ignore case in search
set smartcase                                 " Don't ignore case if an uppercase letter is used
set gdefault                                  " Apply global substitutions by default
set cursorline                                " Hightlight the line the cursor is on
set list                                      " Hightlight whitespace characters
set t_Co=256                                  " Enable 256 color schemes
set background=dark                           " Set dark background
set expandtab                                 " Use spaces not tabs
set tabstop=2                                 " Set indentation to 2 spaces
set shiftwidth=2
set mouse=a                                   " Enable mouse support for all modes
set listchars=tab:▸\ ,trail:·                 " Customize whitespace characters shown
set guifont=Source_Code_Pro_for_Powerline:h16 " Set font
set guioptions-=r                             " Remove scrollbars
set guioptions-=L                             " Remove scrollbars
set clipboard=unnamed                         " Use system clipboard
colorscheme base16-ocean                      " Set color scheme

if has('fullscreen')
  set fullscreen " Start in fullscreen
endif

" Set leader key to comma
let mapleader=","

" ===============================================================================
" Autocommand
" ===============================================================================

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces() " Remove trailing whitespaces automatically when a file is saved
autocmd FocusLost * :wa                                     " Save file on focus lost
autocmd FileType markdown,text setlocal spell               " Enable spell check for text files

" ===============================================================================
" Unite
" ===============================================================================

" Use ag for content searching
if executable('ag')
  let g:unite_source_grep_command        = 'ag'
  let g:unite_source_grep_default_opts   = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt  = ''
  let g:unite_source_grep_max_candidates = 200
endif

" Ignore folders for file searching
call unite#custom#source('file, file_rec/async', 'ignore_pattern', '\.rsync_cache\|\.git\|\images')

" Clear unite's file searching cache
autocmd FileType unite nmap <buffer> <C-r> <Plug>(unite_redraw)

" ===============================================================================
" Neocomplete
" ===============================================================================

let g:neocomplete#enable_at_startup = 1                 " Enable neocomplete
let g:neocomplete#enable_smart_case = 1                 " Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" ===============================================================================
" Emmet-vim
" ===============================================================================

let g:user_emmet_install_global = 0               " Enable just for the given file types
let g:user_emmet_mode='a'                         " Enable all functions in all modes
autocmd FileType html,css,eruby,scss EmmetInstall " Only for frontend code
let g:user_emmet_leader_key='<C-y>'

" ===============================================================================
" Vim-airline
" ===============================================================================
set laststatus=2
set noshowmode

let g:airline_powerline_fonts = 1

" ===============================================================================
" Mappings
" ===============================================================================

nnoremap <C-p> :Unite -start-insert file_rec/async<CR>
nnoremap <leader>b :Unite -quick-match buffer<CR>
nnoremap <leader>f :Unite grep:.<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk
nnoremap ; :
inoremap jj <ESC>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap / /\v
vnoremap / /\v

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
