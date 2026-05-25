scriptencoding utf-8
set encoding=utf-8

let mapleader = "\\"
let maplocalleader = "\\"

set belloff=all

set number
set relativenumber

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set wrap
set linebreak
if exists('+breakindent')
  set breakindent
endif

set ignorecase
set smartcase
set incsearch
set hlsearch

set showcmd

set wildmenu
set wildmode=longest,list

set cursorline

set background=dark

if exists('+termguicolors') && (&term =~# 'xterm\|screen\|tmux\|rxvt\|kitty\|alacritty' || $COLORTERM =~# 'truecolor\|24bit')
  set termguicolors
endif

try
  colorscheme habamax
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

if exists('+signcolumn')
  set signcolumn=auto
endif

set backspace=indent,eol,start

set splitright
set splitbelow

let s:vim_tmp = expand('~/.vim/tmp')
if exists('*mkdir') && !isdirectory(s:vim_tmp)
  call mkdir(s:vim_tmp, 'p')
endif

set swapfile

if exists('+directory')
  execute 'set directory=' . fnameescape(s:vim_tmp) . '//'
endif

if exists('+backupdir')
  execute 'set backupdir=' . fnameescape(s:vim_tmp) . '//'
endif

if has('persistent_undo')
  set undofile
  execute 'set undodir=' . fnameescape(s:vim_tmp) . '//'
endif

set spell
set spelllang=en_us,cjk

let g:have_nerd_font = 1

if has('mouse')
  set mouse=a
endif

set scrolloff=10

set updatetime=250

set foldlevel=99

syntax enable
filetype plugin indent on

nnoremap r<Tab> r<Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
snoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
" inoremap <Leader><Tab> <C-v><Tab>

nnoremap <Tab> :nohlsearch<CR>

nnoremap <C-;> <C-w>v
nnoremap <C-'> <C-w>s
nnoremap <C-\> :close<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-M-h> <C-w>H
nnoremap <C-M-j> <C-w>J
nnoremap <C-M-k> <C-w>K
nnoremap <C-M-l> <C-w>L

nnoremap <Leader>to :tabnew<CR>
nnoremap <Leader>tx :tabclose<CR>
nnoremap <Leader>tl :tabnext<CR>
nnoremap <Leader>th :tabprevious<CR>
nnoremap <Leader>tf :tabnew %<CR>
