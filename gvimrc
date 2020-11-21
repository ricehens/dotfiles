"set background=light
colorscheme molokai
set encoding=utf-8
set guioptions-=T

" Copy to clipboard
set clipboard=unnamedplus " CLIPBOARD

" Forward-backward search
function! SyncTexForward()
    let execstr = "silent !zathura --synctex-forward ".line(".").":".col(".").":%:p %:p:r.pdf &"
    exec execstr
endfunction
au FileType tex nmap <Leader>f :call SyncTexForward()<CR>
