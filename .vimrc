set nocompatible  " be iMproved, required
filetype off      " required

set shell=/bin/sh " Vim doesn't like non POSIX shells i.e. fish

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
Plugin 'Shougo/neocomplete.vim'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'


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

syntax on                   " Enable syntax highlighting
set nowrap                  " Don't wrap lines
set number                  " Enable line numbers
set autoread                " Enable auto-reading of files if they have been changed from the outside
set autowriteall            " Save on buffer switch
set backup                  " Enable creation of backup files
set backupdir=~/.vim/backup " Specify backup directory
set directory=~/.vim/tmp    " Specify temporary swap files directory
set splitright              " Split new buffers to the right and bottom
set splitbelow              " Split new buffers to the right and bottom
set showcmd                 " Display incomplete commands
set hlsearch                " Hightlight search matches
set incsearch               " Incremental search
set list                    " Hightlight whitespace characters
set t_Co=256                " Enable 256 color schemes
set background=dark         " Set dark background

" Soft tab indentation with 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" Customize whitespace characters shown
set listchars=tab:▸\ ,trail:·

if has('gui_running')
  set guifont=Source_Code_Pro_for_Powerline:h16 " Set font
  set guioptions-=r                             " Remove scrollbars
  set guioptions-=L                             " Remove scrollbars
  set cursorline                                " Hightlights the line the cursor is on
  colorscheme base16-ocean                      " Set color scheme
endif

if has('fullscreen')
  set fullscreen " Start in fullscreen
endif

" Remove trailing whitespaces automatically when a file is saved
if has('autocmd')
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
endif

" ===============================================================================
" Unite
" ===============================================================================

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 200
endif

" Ignore folders for unite
call unite#custom#source('file, file_rec/async', 'ignore_pattern', '\.rsync_cache\|\.git\|\images')

autocmd FileType unite nmap <buffer> <C-r> <Plug>(unite_redraw)

" ===============================================================================
" Neocomplete
" ===============================================================================

" Enable neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
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
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()


" ===============================================================================
" Emmet-vim
" ===============================================================================

let g:user_emmet_install_global = 0 "Enable just for the given file types
let g:user_emmet_mode='a'           "Enable all functions in all modes
autocmd FileType html,css,eruby,scss EmmetInstall
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
nnoremap <space>s :Unite -quick-match buffer<CR>
nnoremap <space>f :Unite grep:.<CR>

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
