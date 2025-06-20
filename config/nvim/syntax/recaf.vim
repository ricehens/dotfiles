" Vim syntax file for the recaf language
" Based on the recaf spec for 6.110, Spring 2025
" File extension: .dcf

" Quit if this syntax file has already been loaded.
if exists("b:current_syntax")
  finish
endif

syntax spell notoplevel

" Strings and character literals
syn region recafString start=+"+ skip=+\\.|"+ end=+"+
syn region recafChar   start=+'+ skip=+\\.|'+ end=+'+

" recaf keywords (case-sensitive)
syn keyword recafKeyword if bool break import continue else false for while int long return true void const var func type new module use

" Although the above include types, you can also separately mark them:
syn keyword recafType int long bool void 

" Number literals: hexadecimal and decimal with an optional trailing L for longs.
syn match recafNumber "\<0x[0-9a-fA-F]\+\(L\)\?\>"
syn match recafNumber "\<[0-9]\+\(L\)\?\>"

" Operators (including compound and logical operators)
" syn match recafOperator "==\|!=\|<=\|>=\|&&\|||"
" syn match recafOperator "[+\-*/%]=\|[+\-*/%]"
" Use very nomagic mode (\V) to match literal "++" and "--"
" syn match recafOperator /\V++\|--/

" Delimiters and punctuation
syn match recafDelimiter "[(){}[\],;]"

" Identifiers: match valid names not already highlighted as keywords.
syn match recafIdentifier "\<[A-Za-z_][A-Za-z0-9_]*\>" 
syn match recafClassIdentifier "\<[A-Z][A-Za-z0-9_]*\>" 
syn match recafConstant "\<[A-Z][A-Z0-9_]*\>"

" Function names names
syn match recafFunc "\w\+\ze\s*(" 

" Comments: single-line (//) and block (/* … */)
syn region recafComment start="//" skip="\\$" end="$" keepend contains=@Spell
syn region recafCommentBlock start="/\*" end="\*/" fold contains=@Spell

" Link syntax groups to standard Vim highlight groups
hi def link recafKeyword    Keyword
hi def link recafType       Type
hi def link recafClassIdentifier       Type
hi def link recafConstant       Identifier
" hi def link recafFuncName   Function
hi def link recafFunc       Function
hi def link recafString     String
hi def link recafChar       Character
hi def link recafComment    Comment
hi def link recafCommentBlock Comment
hi def link recafNumber     Number
" hi def link recafOperator   Operator
hi def link recafDelimiter  Delimiter
hi def link recafIdentifier Identifier

let b:current_syntax = "recaf"

