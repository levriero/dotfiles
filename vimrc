" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
  " Color Schemes
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }

  " Indicates vcs changes
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

  " Vim LSP client
  Plug 'dense-analysis/ale'

  " A simple way to create, edit and save files and parent directories
  Plug 'duggiefresh/vim-easydir'

  " Enhancing in-buffer search experience
  Plug 'junegunn/vim-slash'

  " Comment stuff out
  Plug 'tpope/vim-commentary'

  " Quoting/parenthesizing
  Plug 'tpope/vim-surround'

  " A Vim alignment plugin
  Plug 'junegunn/vim-easy-align'

  " A collection of language packs for Vim.
  Plug 'sheerun/vim-polyglot'

  " Vim's runtime files for ruby support
  Plug 'vim-ruby/vim-ruby'

  " Ruby on Rails power tools
  Plug 'tpope/vim-rails'

  " A Vim wrapper for running tests on different granularities.
  Plug 'vim-test/vim-test'

  " Easily interact with tmux from vim
  Plug 'preservim/vimux'

  " Wisely add 'end' in ruby, vim script, and others
  Plug 'tpope/vim-endwise'

  " Distraction-free writing in Vim
  Plug 'junegunn/goyo.vim'

  " Defines text objects to target text after the designated characters.
  Plug 'junegunn/vim-after-object'
call plug#end()


"
" helpers
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let s:darwin = has('mac')


"
" ALE
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" let g:ale_completion_enabled = 1
" let g:ale_set_highlights = 1
let g:ale_sign_warning = "☢"
let g:ale_sign_error = "☹"

" let g:ale_linters = {
"       \   'ruby': ['standardrb', 'solargraph'],
"       \}

" let g:ale_fixers = {
"       \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"       \   'ruby': ['standardrb'],
"       \}


function! SmartInsertCompletion() abort
  " Use the default CTRL-N in completion menus
  if pumvisible()
    return "\<C-n>"
  endif

  " Exit and re-enter insert mode, and use insert completion
  return "\<C-c>a\<C-n>"
endfunction

inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>


"
" signify
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '•'

"
" lightline
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:lightline = {
      \ 'colorscheme': 'material_vim',
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
  set rtp+=/opt/homebrew/opt/fzf
endif

"
" vim-test
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let test#strategy = "vimux"

"
" omnicomplete
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set completeopt=menu,menuone,noinsert,noselect

"disable sql omnicompletion
":help ft-sql :help sql-completion-customization
let g:omni_sql_no_default_maps = 1


" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------

" GUI colors shenanigans
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors

" Enable syntax highlighting
syntax on

" Colorscheme
let g:material_theme_style = 'default' " default, palenight, ocean, lighter, and darker
let g:material_terminal_italics = 1
colorscheme material

" Use system clipboard
if s:darwin
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

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

" Default updatetime 4000ms is not good for async update
set updatetime=100

" Do not create swap files
set noswapfile

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
" nnoremap <leader>e :NERDTreeToggle<CR>

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


" ALE mappings
" ~~~~~~~~~~~~
nnoremap <buffer> gd :ALEGoToDefinition<CR>
nnoremap <buffer> gr :ALEFindReferences<CR>
nnoremap <buffer> gR :ALERename<CR>

nnoremap gd :ALEGoToDefinition<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap gR :ALERename<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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
  autocmd!
  autocmd BufLeave * :update
augroup END

" show/hide current line when entering/leaving buffers
augroup toggle_cursorline
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Rename tmux window with file name
if exists('$TMUX') && !exists('$NORENAME')
  augroup rename_tmux_window
    autocmd!
    autocmd BufEnter * call system('tmux rename-window '.expand('%:t:S'))
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  augroup END
endif

" Enable vim-after-object mappings
augroup enable_after_object
  autocmd!
  autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', ',')
augroup END

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
