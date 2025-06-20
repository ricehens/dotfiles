-- vim.cmd("let g:netrw_liststype = 3")

local opt = vim.opt

-- misc
opt.encoding = "utf-8"
opt.belloff = "all"
opt.nrformats = "alpha" -- increment letters with <C-a>, <C-x> too
-- opt.t_Co = "256"

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
-- opt.cindent = true

-- line wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- recommendations
opt.showcmd = true
opt.incsearch = true
opt.wildmenu = true
opt.ic = true
opt.hls = true

--
-- cursor line
opt.cursorline = true

-- colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard
--
-- split windows
opt.splitright = true
opt.splitbelow = true

-- swapfiles
opt.swapfile = true
opt.undofile = true
opt.directory = vim.fn.expand('~/.config') .. '/nvim/tmp//'
opt.backupdir = vim.fn.expand('~/.config') .. '/nvim/tmp//'
opt.undodir = vim.fn.expand('~/.config') .. '/nvim/tmp//'

-- search like bash
opt.wildmenu = true
opt.wildmode = "longest,list"

-- spell
opt.spelllang = en_us
opt.spell = true

-- custom filetypes
vim.filetype.add({ extension = { dcf = "decaf", ms = "bsv", rcf = "recaf" }, })
