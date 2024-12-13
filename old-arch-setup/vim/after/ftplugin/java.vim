""" YouCompleteMe should be enabled

" ==== Useful auto-completions ====
" Insert tab
inoremap <Leader><Tab> <Tab>

" Auto-complete braces
inoremap {<CR> {<CR>}<Esc>ko
inoremap ( ()<++><ESC>5hli
inoremap [<Space> []<++><ESC>5hli

inoremap psvm<Space> public static void main(String[] args)
inoremap sout<Space> System.out.println()<++><ESC>5hli

" ==== Adapted from dotfiles of Gavin Sinclair ====
" This thing (`) prefixes a KEYWORD abbreviation
inoremap <buffer> `c class
inoremap <buffer> `i interface
inoremap <buffer> `I implements
inoremap <buffer> `m import
inoremap <buffer> `f final
inoremap <buffer> `s static
inoremap <buffer> `y synchronized
inoremap <buffer> `e extends
inoremap <buffer> `p public
inoremap <buffer> `P private
inoremap <buffer> `o protected
inoremap <buffer> `a package

" Colon (:) prefixes a FLOW abbreviation
inoremap <buffer> :f for
inoremap <buffer> :w while
inoremap <buffer> :s switch
inoremap <buffer> :C case
inoremap <buffer> :b break
inoremap <buffer> :d default
inoremap <buffer> :i if
inoremap <buffer> :r return
inoremap <buffer> :t try
inoremap <buffer> :c catch
inoremap <buffer> :f finally
inoremap <buffer> :T throws
inoremap <buffer> :R throw

" CTRL + T (^T) prefixes a TYPE abbreviation
inoremap <buffer> <C-T>i int
inoremap <buffer> <C-T>I Integer
inoremap <buffer> <C-T>l long
inoremap <buffer> <C-T>L Long
inoremap <buffer> <C-T>b boolean
inoremap <buffer> <C-T>B Boolean
inoremap <buffer> <C-T>c char
inoremap <buffer> <C-T>C Char
inoremap <buffer> <C-T>d Double
inoremap <buffer> <C-T>D Double
inoremap <buffer> <C-T>v void
inoremap <buffer> <C-T>V Void
inoremap <buffer> <C-T>s String
inoremap <buffer> <C-T>S String
inoremap <buffer> <C-T>e Exception
inoremap <buffer> <C-T>E Exception

" CTRL + Underscore (_) prefixes a GENERAL abbreviation
inoremap <buffer> <C-_>m public static void main(String args[])
inoremap <buffer> <C-_>o System.out.println(X);<Esc>FXs
inoremap <buffer> <C-_>e System.err.println(X);<Esc>FXs
inoremap <buffer> <C-_>t true
inoremap <buffer> <C-_>f false
inoremap <buffer> <C-_>E e.printStackTrace();
inoremap <buffer> <C-_>C <C-V><code>
inoremap <buffer> <C-_>c <C-V></code>

" Helpful mappings when creating a new object
" Type: Object o<C-T>o
" Get:  Object o = new Object();
" <C-T>O leaves the cursor between the parentheses.
inoremap <buffer> <C-T>o <C-O>A = new <Esc>^yE<End>pA();<CR>
inoremap <buffer> <C-T>O <C-O>A = new <Esc>^yE<End>pA();<Left><Left>

" To create a javadoc comment above the current line
nnoremap Zc O/**<CR><BS>*<CR>*/<Up><Space>

" Useful when editing javadoc comments
nnoremap ZR :se formatoptions+=ro<CR>
nnoremap Zr :se formatoptions-=ro<CR>
