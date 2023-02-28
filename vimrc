" ----------------------------------------------------------------------------
" Options
" ----------------------------------------------------------------------------
set termguicolors

" GUI colors shenanigans
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax on
colorscheme slate

set clipboard=unnamedplus
set completeopt=menu,menuone,noinsert,noselect
set backspace=indent,eol,start

" Enable auto-reading of files if they have been changed from the outside
set autoread

" Show  line numbers
set number

" Enable autoindent
set autoindent

" Use 2 spaces for indentation
set expandtab
set tabstop=2
set shiftwidth=2

" Autocomplete commands
set showcmd
set wildmenu

" Show bracket matches
set showmatch

" Hightlight search matches
set hlsearch

" Incremental search
set incsearch

" Searches wrap around the end of the file
set wrapscan

" Case-insensitive search
set ignorecase

" Use case-sensitive searching if expression contains capital letter
set smartcase

" Hightlight whitespace characters
set list
set listchars=tab:▸\ ,trail:·

" Display status var
set laststatus=2

" Save on 'focus' switch
set autowrite
set autowriteall

" Hide showmode
set noshowmode

set updatetime=50

" Do not create swap files
set noswapfile

" Set leader key to space
let mapleader="\<space>"

" ----------------------------------------------------------------------------
" Key Mappings
" ----------------------------------------------------------------------------

" keep cursor position
nnoremap j gj
nnoremap k gk

" Faster command mode
nnoremap ; :
nnoremap : ;

" Vertical buffer split
nnoremap <leader>- <C-w>s

" Horizontal buffer split
nnoremap <leader>\ <C-w>v

" create a new file in the open buffer dir
nnoremap <Leader>nf :e %:h/

" Make all windows equal
nnoremap <leader>= :wincmd =<cr>

" where am I
nnoremap <leader>w :echo @%<cr>

" copy `pwd` to clipboard
nnoremap <silent><leader>cp :let @+ = expand("%:p")<cr>

nnoremap <leader>e :Explore<CR>

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
