""""" Defaults
set nocompatible
set backspace=indent,eol,start
set smartcase

""""" Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-latex/vim-latex'

call vundle#end()            " required
filetype plugin indent on    " required

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

""""" END DEFAULTS

set showcmd incsearch wildmenu
set ic hls " incomplete, highlight search

""" Set TAB to ESC // or just swap the system keys :P
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
"inoremap <Leader><Tab> <Tab>

""" Syntax highlighting
syntax on
set background=dark

""" Line wrapping
set wrap
set linebreak
set nolist

""" LaTeX
filetype plugin on
filetype indent on
let g:tex_flavor='latex'
set sw=2
set iskeyword+=:
set shellcmdflag=-ic

""" Recognize indention while hard-breaking lines
set breakindent
"set showbreak=\ \

""" C++/Java
set cindent

" Indention
filetype plugin indent on
set expandtab ts=4 sw=4 ai

" Code Folding looks shitty
highlight Folded ctermbg=LightBlue ctermfg=DarkBlue
