if exists("b:current_syntax")
  finish
endif

syntax spell notoplevel
syn region mitString start=+"+ skip=+\\.|"+ end=+"+
syn keyword mitKeyword global if else while return fun true false None
syn match mitNumber "\<[0-9]\+\>"
syn match mitDelimiter "[(){}[\],;.:]"
syn match mitIdentifier "\<[A-Za-z_][A-Za-z0-9_]*\>"
syn match mitFunc "\w\+\ze\s*(" 
syn region mitComment start="//" skip="\\$" end="$" keepend contains=@Spell

hi def link mitKeyword    Keyword
hi def link mitFunc       Function
hi def link mitString     String
hi def link mitComment    Comment
hi def link mitNumber     Number
hi def link mitDelimiter  Delimiter
hi def link mitIdentifier Identifier

let b:current_syntax = "mitscript"

