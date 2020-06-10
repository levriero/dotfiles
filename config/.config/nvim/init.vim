" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------

call plug#begin(stdpath('data') . '/plugged')

" Color Schemes
Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'
Plug 'arzg/vim-colors-xcode'

" Signify uses the sign column to indicate added, modified and removed lines
" in a file that is managed by a version control system (VCS).
Plug 'mhinz/vim-signify'

" A light and configurable statusline/tabline plugin for Vim.
Plug 'itchyny/lightline.vim'

" Git wrapper.
Plug 'tpope/vim-fugitive'

" A git commit browser.
Plug 'junegunn/gv.vim'

" A command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" A simple way to create, edit and save files and parent directories
Plug 'duggiefresh/vim-easydir'

" Enhancing in-buffer search experience
Plug 'junegunn/vim-slash'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Quoting/parenthesizing
Plug 'tpope/vim-surround'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" Vim/Ruby Configuration Files
Plug 'vim-ruby/vim-ruby'

" Ruby on Rails power tools
Plug 'tpope/vim-rails'

" File system explorer
Plug 'preservim/nerdtree'

" A simple, vimscript only, command runner for sending commands from vim to tmux.
Plug 'christoomey/vim-tmux-runner'

" A Vim wrapper for running tests on different granularities.
Plug 'vim-test/vim-test'

" Wisely add 'end' in ruby, vim script, and others
Plug 'tpope/vim-endwise'

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'

" Minimalist autocompletion plugin
Plug 'lifepillar/vim-mucomplete'

call plug#end()

let s:darwin = has('mac')

"
" xcode colorscheme (light high contrast)
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:xcodelighthc_dim_punctuation = 0

"
" signify
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '•'

"
" lightline
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:lightline = {
      \ 'colorscheme': 'ayu_light',
      \ 'active': {
      \ 'left': [['mode', 'paste'], ['fugitive', 'readonly', 'filename', 'modified']],
      \ 'right': [['lineinfo'], ['percent'], [ 'fileformat', 'fileencoding', 'filetype']],
      \ },
      \ 'component_function': {
      \ 'fugitive': 'LightlineFugitive'
      \ }
      \ }

"
" fzf
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if s:darwin
  set rtp+=/usr/local/opt/fzf
endif


"
" syntastic
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq   = 0

"
" vim-test
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let test#strategy = "vtr"

"
" syntastic
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:syntastic_error_symbol         = "☠"
let g:syntastic_warning_symbol       = "⚠"
let g:syntastic_style_error_symbol   = "☢"
let g:syntastic_style_warning_symbol = "☹"

"
" mucomplete / omnicomplete
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set completeopt+=menuone
set completeopt+=noselect

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay       = 1

" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------

" Enable syntax highlighting
syntax enable

" Colorscheme
set termguicolors
colorscheme xcodelighthc

set background=light

" Use system clipboard
if s:darwin
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

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

" Default updatetime 4000ms is not good for async update
set updatetime=100

" Set leader key to space
let mapleader="\<space>"


" ----------------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------------

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


function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

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
nnoremap <leader>v <C-w>v<C-w>l

" Horizontal buffer split
nnoremap <leader>h <C-w>s<C-w>j

" create a new file in the open buffer dir
nnoremap <Leader>nf :e %:h/

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" where am I
nnoremap <leader>w :echo @%<cr>

" copy `pwd` to clipboard
nnoremap <silent><leader>cp :let @+ = expand("%:p")<cr>

" ruby specific: insert breakpoint
nnoremap <leader>d obinding.pry<esc>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" fzf mappings
nnoremap <leader>f :Rg<space>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>c :Commits<CR>
nnoremap <leader>cb :BCommits<CR>

" Open NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" run current test file (vim-test)
nnoremap <Leader>rc :TestFile<CR>

" run nearest test file (vim-test)
nnoremap <Leader>rn :TestNearest<CR>

" run last test file (vim-test)
nnoremap <Leader>rl :TestLast<CR>

" visits the test file from which you last run your tests
nnoremap <Leader>rv :TestVisit<CR>

" attach to existing tmux pane
nnoremap <leader>ra :VtrAttachToPane<cr>

" send VISUAL selection to attached pane
vnoremap <leader>rs :VtrSendLinesToRunner<cr>

" ----------------------------------------------------------------------------
" Autocommand
" ----------------------------------------------------------------------------

" Remove trailing whitespaces automatically when a file is saved
augroup strip_trailing_white_spaces
  autocmd!
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END

" Enable spell check for text files
augroup spellcheck
  autocmd!
  autocmd FileType markdown,text setlocal spell textwidth=0
augroup END

" Save on buffer focus lost
augroup save_on_buffer_focus_lost
  autocmd! BufLeave * :update
augroup END

" show/hide current line when entering/leaving buffers
augroup toggle_cursorline
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Rename tmux window with file name
if exists('$TMUX') && !exists('$NORENAME')
  augroup rename_tmux_window
    autocmd BufEnter * call system('tmux rename-window '.expand('%:t:S'))
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  augroup END
endif

" Auto completion settings for ruby files
augroup filetype_ruby
  autocmd!
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading    = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails             = 1
augroup END
