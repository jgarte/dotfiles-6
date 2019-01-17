" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required

" UTF8 Please
set encoding=utf-8

" Initialize Vim Plugged
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jremmen/vim-ripgrep'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

" If you've already got fzf on your path it looks like this just
" creates a symlink to it. A bit weird but here we are.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Use CTRL-P for FZF
nmap <C-P> :FZF<CR>

" Don't save .swap files, they're annoying
set nobackup
set noswapfile
set nowritebackup

set showcmd		" display incomplete commands

" Colour scheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  set hlsearch
endif

" Switch wrap off for everything
set nowrap

" Configure better whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

if has("autocmd")
  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

  augroup END
endif

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" \ is the leader character
let mapleader = "\\"

" No Help, please
nmap <F1> <Esc>

" Numbers
set number
set numberwidth=5

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags"
set tags=./tags;

" Give a shortcut key to NERD Tree
nmap tt :NERDTreeToggle<CR>

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1

" vim json
let g:vim_json_syntax_conceal = 0

" ALE
let g:ale_linters = {
\   'javascript': ['standard'],
\   'ruby': ['rubocop'],
\   'haskell': ['hlint'],
\}

let g:ale_fixers = {
\   'elm': ['format'],
\   'typescript': ['prettier'],
\   'javascript': ['prettier'],
\}

let g:ale_fix_on_save = 1
