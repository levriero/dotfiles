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
Plug 'whatyouhide/vim-gotham'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'itchyny/lightline.vim'

" Navigation
Plug 'justinmk/vim-gtfo'
Plug 'duggiefresh/vim-easydir'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'mhinz/vim-startify'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-after-object'
Plug 'whatyouhide/vim-lengthmatters'

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

" ----------------------------------------------------------------------------
" General Settings
" ----------------------------------------------------------------------------
" Enable syntax highlighting
syntax enable

" Set colorscheme
set t_Co=256
colorscheme gotham

" Notify of running fast terminal, improves redrawing
set ttyfast

" Don't redraw when running macros
set lazyredraw

" Speed up scroll displaying
set ttyscroll=3

" Maximum column number to highlight
set synmaxcol=250

" Show (relative) line numbers
set number
set relativenumber

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

" Apply global substitutions by default
set gdefault

" Hightlight whitespace characters
set list
set listchars=tab:▸\ ,trail:·

" Use 2 spaces for indentation
set expandtab
set tabstop=2
set shiftwidth=2

" Use the system clipboard for yanking
set clipboard=unnamed

" Disable beeping sounds
set noerrorbells
set novisualbell

" Display status var
set laststatus=2

" Don't show default vim mode information
set noshowmode

" Set a maximum width of text, mostly for lengthmatters
set textwidth=80

" Use real english
set spelllang=en_gb

" Add dictionary scanning
set complete+=kspell

" Set leader key to space
let mapleader="\<space>"

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ----------------------------------------------------------------------------
" Autocommand
" ----------------------------------------------------------------------------
" Remove trailing whitespaces automatically when a file is saved
augroup strip_trailing_white_spaces
  autocmd!
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END

" Enable spell check and line wrapping for text files
augroup spellcheck
  autocmd!
  autocmd FileType markdown,text setlocal spell wrap linebreak nolist
augroup END

" Save on buffer focus lost
augroup save_on_buffer_focus_lost
  autocmd! BufLeave * :update
augroup END

" Automatically rebalance windows on vim resize
augroup reposition_buffer_on_vim_resize
  autocmd VimResized * :wincmd =
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
let g:netrw_list_hide = '.git,.DS_Store,.sass-cache'
let g:netrw_liststyle = 3 " Use tree style

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
      \ 'colorscheme': 'gotham',
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

" ----------------------------------------------------------------------------
" fzf
" ----------------------------------------------------------------------------

" Select buffer
" ~~~~~~~~~~~~~~~~~~~
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

" Fuzzy ag
" ~~~~~~~~~~~~~~~~~~~
function! s:escape(path)
  return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! AgHandler(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
endfunction

command! -nargs=+ Search call fzf#run({
      \ 'source': 'ag "<args>"',
      \ 'sink': function('AgHandler'),
      \ 'options': '+m',
      \ 'down': '40%'
      \ })

nnoremap <leader>f :Search<space>
nnoremap <silent><Leader>p :call fzf#run({ 'down': '40%', 'sink': 'e'})<CR>
nnoremap <silent><Leader>b :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('<sid>bufopen'),
      \   'options': '+m',
      \   'down':    len(<sid>buflist()) + 2
      \ })<CR>

" ----------------------------------------------------------------------------
" vim-rspec
" ----------------------------------------------------------------------------
let g:rspec_command = "call VtrSendCommand('spring rspec {spec}')"

nnoremap <Leader>rc :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rn :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>

" ----------------------------------------------------------------------------
" VimTmuxRunner
" ----------------------------------------------------------------------------
nnoremap <leader>ta :VtrAttachToPane<cr>
nnoremap <leader>tl :VtrSendLinesToRunner<cr>
vnoremap <leader>tl :VtrSendLinesToRunner<cr>

" ----------------------------------------------------------------------------
" vim-after-object
" ----------------------------------------------------------------------------
autocmd VimEnter * call after_object#enable('=', ':')


" ----------------------------------------------------------------------------
" startify
" ----------------------------------------------------------------------------
let g:startify_custom_header =
      \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------
" clear those pesky search highlights
nnoremap <leader><space> :noh<CR>

" Open netrw
nnoremap <leader>e :Explore<CR>

" keep cursor position
nnoremap j gj
nnoremap k gk

" <escape> it too far
inoremap jk <ESC>

" split horizontally
nnoremap <leader>v <C-w>v<C-w>l

" split vertically
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" One press command mode
nnoremap ; :
nnoremap : ;

" create a new file in the open buffer dir
nnoremap <Leader>n :e %:h/

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

" ----------------------------------------------------------------------------
" clojure
" ----------------------------------------------------------------------------
augroup lisp
  autocmd!
  autocmd FileType clojure,scheme RainbowParentheses
augroup END

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

" <Leader>? | Google it
" ----------------------------------------------------------------------------
function! s:goog(pat)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
        \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system('open https://www.google.com/search?q='.q)
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"))<cr>
xnoremap <leader>? "gy:call <SID>goog(@g)<cr>gv
