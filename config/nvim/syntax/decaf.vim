" Vim syntax file for the Decaf language
" Based on the Decaf spec for 6.110, Spring 2025
" File extension: .dcf

" Quit if this syntax file has already been loaded.
if exists("b:current_syntax")
  finish
endif

" Strings and character literals
syn region decafString start=+"+ skip=+\\.|"+ end=+"+
syn region decafChar   start=+'+ skip=+\\.|'+ end=+'+

" Decaf keywords (case-sensitive)
syn keyword decafKeyword if bool break import continue else false for while int long return len true void

" Although the above include types, you can also separately mark them:
syn keyword decafType int long bool void

" Number literals: hexadecimal and decimal with an optional trailing L for longs.
syn match decafNumber "\<0x[0-9a-fA-F]\+\(L\)\?\>"
syn match decafNumber "\<[0-9]\+\(L\)\?\>"

" Operators (including compound and logical operators)
" syn match decafOperator "==\|!=\|<=\|>=\|&&\|||"
" syn match decafOperator "[+\-*/%]=\|[+\-*/%]"
" Use very nomagic mode (\V) to match literal "++" and "--"
" syn match decafOperator /\V++\|--/

" Delimiters and punctuation
syn match decafDelimiter "[(){}[\],;]"

" Identifiers: match valid names not already highlighted as keywords.
syn match decafIdentifier "\<[A-Za-z_][A-Za-z0-9_]*\>"

" Function names names
syn match decafFunc "\w\+\ze\s*(" 

" Comments: single-line (//) and block (/* … */)
syn region decafComment start="//" skip="\\$" end="$" keepend
syn region decafCommentBlock start="/\*" end="\*/" fold

" Link syntax groups to standard Vim highlight groups
hi def link decafKeyword    Keyword
hi def link decafType       Type
" hi def link decafFuncName   Function
hi def link decafFunc       Function
hi def link decafString     String
hi def link decafChar       Character
hi def link decafComment    Comment
hi def link decafCommentBlock Comment
hi def link decafNumber     Number
" hi def link decafOperator   Operator
hi def link decafDelimiter  Delimiter
hi def link decafIdentifier Identifier

let b:current_syntax = "decaf"

