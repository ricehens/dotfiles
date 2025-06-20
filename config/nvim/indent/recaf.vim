" Vim indentation file for Recaf language

" Prevent multiple loads
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Use a custom indent expression.
setlocal indentexpr=GetDecafIndent(v:lnum)
" Define keys that trigger reindenting.
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e

" Simple indentation function:
function! GetDecafIndent(lnum)
  " First line should have zero indent.
  if a:lnum == 1
    return 0
  endif

  " Find the previous non-blank line.
  let prev = prevnonblank(a:lnum - 1)
  if prev == 0
    return 0
  endif

  " Get current indent from previous line.
  let ind = indent(prev)
  let line = getline(prev)

  " Increase indent if the previous line ends with an opening brace.
  if line =~ '{\s*$'
    let ind += &shiftwidth
  endif

  " If the current line starts with a closing brace, reduce indent.
  let curr = getline(a:lnum)
  if curr =~ '^\s*}'
    let ind = ind - &shiftwidth
  endif

  return ind
endfunction

