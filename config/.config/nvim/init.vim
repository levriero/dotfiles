call plug#begin('~/.vim/plugged')

" UI
" Plug 'cocopon/iceberg.vim'
Plug 'ayu-theme/ayu-vim'
" Plug 'arcticicestudio/nord-vim'

Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

" File searching
Plug 'justinmk/vim-gtfo'
Plug 'duggiefresh/vim-easydir'
Plug 'junegunn/vim-slash'

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

" Writing
Plug 'junegunn/goyo.vim'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-after-object'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'junegunn/vim-easy-align'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'

" Languages
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-test/vim-test'

call plug#end()

" Enable syntax highlighting
syntax enable

" Set colorscheme
set termguicolors
let ayucolor="light"
colorscheme ayu

" Show  line numbers
set number

" Enable autoindent
set autoindent

" Show bracket matches
set showmatch

" Enable auto-reading of files if they have been changed from the outside
set autoread

" Save on 'focus' switch
set autowrite
set autowriteall

" Sane backspacing
set backspace=indent,eol,start

" Disable backup files
set nobackup
set noswapfile

" Hide buffers instead of closing them
set hidden

" Split new buffers to the right
set splitright

" Autocomplete commands
set showcmd
set wildmenu

" Hightlight search matches
set hlsearch

" Incremental search
set incsearch

" Case-insensitive searching
set ignorecase

" Use case-sensitive searching if expression contains capital letter
set smartcase

" Searches wrap around the end of the file
set wrapscan

" Apply global substitutions by default
set gdefault

" Hightlight whitespace characters
set list
set listchars=tab:▸\ ,trail:·

" Use 2 spaces for indentation
set expandtab
set tabstop=2
set shiftwidth=2

" Use the CLIPBOARD register
set clipboard=unnamedplus

" Disable beeping sounds
set noerrorbells
set novisualbell

" Display status var
set laststatus=2

" Don't show default vim mode information
set noshowmode

" Set a maximum width of text, mostly for lengthmatters
set textwidth=80

" Visual wrap lines
set wrap

" Wrap on whitespace
set lbr

" disable netrw history
let netrw_dirhistmax = 0

" Set leader key to space
let mapleader="\<space>"

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

" Use bash syntax for .bats files
augroup set_filetype_for_bats_files
  autocmd BufNewFile,BufRead *.bats set filetype=sh
augroup END

" show/hide current line when entering/leaving buffers
augroup toggle_cursorline
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Automatic rename of tmux window
if exists('$TMUX') && !exists('$NORENAME')
  augroup rename_tmux_window
    autocmd BufEnter * call system('tmux rename-window '.expand('%:t:S'))
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  augroup END
endif

" ----------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------
let g:netrw_list_hide    = '.git/'
let g:netrw_liststyle    = 3  " Use tree style
let g:netrw_banner       = 0  " Hide directory banner
let g:netrw_browse_split = 2  " Split vertically and open file
let g:netrw_winsize      = 20 " Width percentage

" ----------------------------------------------------------------------------
" syntastic
" ----------------------------------------------------------------------------
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_error_symbol = "☠"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "☢"
let g:syntastic_style_warning_symbol = "☹"

" ----------------------------------------------------------------------------
" vim-signify
" ----------------------------------------------------------------------------
let g:signify_vcs_list = ['git']

" ----------------------------------------------------------------------------
" lightline
" ----------------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'ayu',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['fugitive', 'readonly', 'filename', 'modified']],
      \   'right': [['lineinfo'], ['percent'], [ 'fileformat', 'fileencoding', 'filetype']],
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive'
      \ }
      \ }

function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

" ----------------------------------------------------------------------------
" fzf
" ----------------------------------------------------------------------------

nnoremap <leader>f :Rg<space>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>c :Commits<CR>
nnoremap <leader>cb :BCommits<CR>

" ----------------------------------------------------------------------------
" vim-test
" ----------------------------------------------------------------------------
let test#strategy = "vtr"

nnoremap <Leader>rc :TestFile<CR>
nnoremap <Leader>rn :TestNearest<CR>
nnoremap <Leader>rl :TestLast<CR>
" Visits the test file from which you last run your tests
nnoremap <Leader>rv :TestVisit<CR>

" ----------------------------------------------------------------------------
" VimTmuxRunner
" ----------------------------------------------------------------------------
nnoremap <leader>ta :VtrAttachToPane<cr>
vnoremap <leader>tl :VtrSendLinesToRunner<cr>

" ----------------------------------------------------------------------------
" EasyAlign
" ----------------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" vim-after-object
" ----------------------------------------------------------------------------
autocmd VimEnter * call after_object#enable('=', ':')


" ----------------------------------------------------------------------------
" Goyo
" ----------------------------------------------------------------------------
function! s:goyo_enter()
  LengthmattersDisable
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()

" ----------------------------------------------------------------------------
" gtfo.vim
" ----------------------------------------------------------------------------
let g:gtfo#terminals = { 'unix': 'alacritty --working-directory $(pwd -P) &' }

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

" Open netrw
nnoremap <leader>e :Lex<CR>

" keep cursor position
nnoremap j gj
nnoremap k gk

" split horizontally
nnoremap <leader>h <C-w>s<C-w>j

" split vertically
nnoremap <leader>v <C-w>v<C-w>l

" One press command mode
nnoremap ; :
nnoremap : ;

" create a new file in the open buffer dir
nnoremap <Leader>nf :e %:h/

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" regenerate ctags
nnoremap <leader>r :!ctags -R .<cr>

" where am I
nnoremap <leader>w :echo @%<cr>

" save a session (uses startify)
nnoremap <leader>ss :SSave<cr>

" load a session (uses startify)
nnoremap <leader>sl :SLoad<cr>

" insert a binding.pry
nnoremap <leader>d obinding.pry<esc>

" open devnotes
nnoremap <leader>nn :call DevNotes()<cr>

" copy `pwd` to clipboard
nnoremap <silent><leader>cp :let @+ = expand("%:p")<cr>

" place the current search match at the center of the window
noremap <plug>(slash-after) zz

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
