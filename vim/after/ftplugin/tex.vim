""" Soft wrapping
set wrap linebreak nolist " soft wrap

""" Based on the dotfiles of Evan Chen.

" Always use \\dots
" call IMAP('...', "\\dots",'tex')

" Disable sections
" call IMAP('SPA', 'SPA', 'tex')
" call IMAP('SCH', 'SCH', 'tex')
" call IMAP('SSE', 'SSE', 'tex')
" call IMAP('SSS', 'SSS', 'tex')
" call IMAP('SS2', 'SS2', 'tex')
" call IMAP('SPG', 'SPG', 'tex')
" call IMAP('SSP', 'SSP', 'tex')
call IMAP('EFI', 'EFI', 'tex')

" Standard macros
let @d = '0i�kb	j'

" Enumeration environments
call IMAP('enum ', "\\begin{enumerate}\<CR>\\item <++>\<CR>\\end{enumerate}<++>\<ESC>k<<",'tex')
call IMAP('itemize ', "\\begin{itemize}\<CR>\\item <++>\<CR>\\end{itemize}<++>\<ESC>k<<",'tex')
call IMAP('enuma ', "\\begin{enumerate}[<++>]\<CR>\\item <++>\<CR>\\end{enumerate}<++>\<ESC>k<<",'tex')
" call IMAP('.desc ', "\\begin{description}\<CR>\\item[<++>] <++>\<CR>\\end{description}<++>\<ESC>k<<",'tex')

"Other environments
call IMAP('.fasy ', "\\begin{figure}[ht]\<CR>\\centering\<CR>\\begin{asy}\<CR><++>\<CR>\\end{asy}\<CR>\\caption{<++>}\<CR>\\end{figure}<++>", 'tex')
call IMAP('.asy ', "\\begin{asy}\<CR><++>\<CR>\\end{asy}<++>", 'tex')
call IMAP('.casy ', "\\begin{center}\<CR>\\begin{asy}\<CR><++>\<CR>\\end{asy}\<CR>\\end{center}<++>\<ESC>k<<k<<k<<", 'tex')
call IMAP('.ftk ', "\\begin{center}\<CR>\\begin{tikzpicture}[scale=<++>]\<CR>\\SetVertex<++>\<CR><++>\<CR>\\end{tikzpicture}\<CR>\\end{center}<++>", 'tex')
" call IMAP('.block ', "\\begin{block}{<++>}\<CR><++>\<CR>\\end{block}<++>", 'tex')
" call IMAP('.ablock ', "\\begin{alertblock}{<++>}\<CR><++>\<CR>\\end{alertblock}<++>", 'tex')
" call IMAP('.eblock ', "\\begin{exampleblock}{<++>}\<CR><++>\<CR>\\end{exampleblock}<++>", 'tex')
call IMAP('.center ', "\\begin{center}\<CR><++>\<CR>\\end{center}<++>", 'tex')
call IMAP('.frame ', "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}<++>", 'tex')
call IMAP('.align ', "\\begin{align*}\<CR><++>\<CR>\\end{align*}<++>", 'tex')
call IMAP('.box ', "\\begin{mdframed}\<CR><++>\<CR>\\end{mdframed}<++>", 'tex')
" call IMAP('.diag ', "\\begin{diagram}\<CR><++>\<CR>\\end{diagram}<++>", 'tex')
call IMAP('.cd ', "\\begin{center}\<CR>\\begin{tikzcd}\<CR><++>\<CR>\\end{tikzcd}\<CR>\\end{center}<++>\<ESC>k<<k<<k<<", 'tex')
call IMAP('.cases ', "\\begin{cases}\<CR><++>\<CR>\\end{cases}<++>", 'tex')
call IMAP('.fig ', "\\begin{figure}[ht]\<CR>\\centering\<CR>\\includegraphics[<++>]{<++>}\<CR>\\caption{<++>}\<CR>\\end{figure}\<CR><++>", 'tex')
call IMAP('.img ', "\\begin{center}\<CR>\\includegraphics[<++>]{<++>}\<CR>\\end{center}\<CR><++>", 'tex')
call IMAP('.code ', "\\begin{lstlisting}\<CR><++>\<CR>\\end{lstlisting}\<CR><++>\<ESC>k<<", 'tex')
call IMAP('.bmat ', "\\begin{bmatrix}\<CR><++>\<CR>\\end{bmatrix}<++>", 'tex')
call IMAP('.beg ', "\\begin{<++>}\<CR><++>\<CR>\\end{<++>}<++>", 'tex') " BEST IDEA EVER

"Miscellaneous maps
call IMAP('<C-/>', "\\frac{<++>}{<++>}<++>", 'tex')
call IMAP('[]', "[]", 'tex')
call IMAP('\[', "\\[<++>\\]<++>", 'tex')
call IMAP('<<', "\\left<<++>\\right><++>", 'tex')
call IMAP('||', "\\left\\lvert<++>\\right\\rvert<++>", 'tex')
call IMAP('.floor ', "\\left\\lfloor <++>\\right\\rfloor<++>", 'tex')
call IMAP('.ceil ', "\\left\\lceil <++>\\right\\rceil<++>", 'tex')
call IMAP('.cycsum ', "\\sum_\\mathrm{cyc}", 'tex')
call IMAP('.symsum ', "\\sum_\\mathrm{sym}", 'tex')
call IMAP('.cycprod ', "\\prod_\\mathrm{cyc}", 'tex')
call IMAP('.symprod ', "\\prod_\\mathrm{sym}", 'tex')
"call IMAP('.si ', "\\SI[per-mode=symbol]{<++>}{<++>}<++>", 'tex')
call IMAP('.si ', "\\;\\si[per-mode=symbol]{<++>}<++>", 'tex')

" TeX Customizations
let g:Tex_FoldedEnvironments='titlepage,abstract,asy,usamts' " Folding of certain environments
let g:Tex_Leader=',' " No more backtick nonsense
set iskeyword+=: " Autocomplete for fig: etc. references
set iskeyword+=_ " Add _ to autocomplete list

"Syntax highlighting: render asymptote
syntax include @ASY after/ftplugin/asy.vim
syntax region asySnip matchgroup=Snip start="\\begin{asy}" end="\\end{asy}" contains=@ASY containedin=texPartZone,texChapterZone,texSectionZone,texSubSectionZone,texSubSubSectionZone,texDocZone
syntax region asySnip matchgroup=Snip start="\\begin{asydef}" end="\\end{asydef}" contains=@ASY containedin=texPartZone,texChapterZone,texSectionZone,texSubSectionZone,texSubSubSectionZone,texDocZone
hi link Snip PreProc

" wef why were these removed in f0b03c4e98f8a7184d8b4a5d702cbcd602426923
" call TexNewMathZone("V","align",1)
" call TexNewMathZone("W","alignat",1)
" call TexNewMathZone("X","flalign",1)
" call TexNewMathZone("Y","multiline",1)
" call TexNewMathZone("Z","gather",1)


" Include cleverref as a ref in highlighting.
syn region texRefZone		matchgroup=texStatement start="\\cref{"	end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\Cref{"	end="}\|%stopzone\>"	contains=@texRefGroup

" Highlight \alert, \vocab like \emph
syn match texTypeStyle		"\\vocab\>"
" syn match texTypeStyle		"\\alert\>"

" Highlight diagram as math environment.
" call TexNewMathZone("Z","diagram",0)
" call TexNewMathZone("Z","tikzcd",0)
" call TexNewMathZone("Z","ytableau",0)

" TeX Conceal
" set cole=2

" Conceal modifications
if has("gui_running") 
	" Match ^(-1)
	" syntax match Minus contained "\\i" conceal cchar=⁻
 	" syntax match One contained "nv" conceal cchar=¹
	" syntax match MinusOne "\\inv\>" containedin=texStatement contains=Minus,One
	
	" Match 1/2, and other symbls
	" syntax match texMathSymbol "\\half\>" contained conceal cchar=½
	syntax match texMathSymbol "\\eps\>" contained conceal cchar=ε
    syntax match texMathSymbol "\\da\>" contained conceal cchar=∡
    " syntax match texMathSymbol "\\then\>" contained conceal cchar=⊃

	" Match absolute value bars
	syntax match texMathSymbol "\\left\\lvert\>" contained conceal cchar=|
	syntax match texMathSymbol "\\right\\rvert\>" contained conceal cchar=|
	syntax match texMathSymbol "\\left<\>" contained conceal cchar=<
	syntax match texMathSymbol "\\right<\>" contained conceal cchar=>
	syntax match texMathSymbol "\\left\\langle\>" contained conceal cchar=<
	syntax match texMathSymbol "\\right\\rangle\>" contained conceal cchar=>

	" Flip the phi so that it's right.
	fun! s:Greek(group,pat,cchar)
		exe 'syn match '.a:group." '".a:pat."' contained conceal cchar=".a:cchar
	endfun
	call s:Greek('texGreek','\\varphi\>'		,'φ')
	call s:Greek('texGreek','\\phi\>'		,'ϕ')
endif

" Map <C-M> to 'Put word in math mode'
nnoremap <C-M> i$<Esc>ea$<Esc>

" Spell
syntax spell toplevel
set nospell

" amsthm environments
call IMAP('pf::', "\\begin{proof}\<CR><++>\<CR>\\end{proof}<++>", 'tex')
call IMAP('pf[]::', "\\begin{proof}[<++>]\<CR><++>\<CR>\\end{proof}<++>", 'tex')
call IMAP('cbpf::', "\\begin{customboxproof}{<++>}\<CR><++>\<CR>\\end{customboxproof}<++>", 'tex')
call IMAP('bpf::', "\\begin{boxproof}\<CR><++>\<CR>\\end{boxproof}<++>", 'tex')
call IMAP('csol::', "\\begin{customsol}{<++>}\<CR><++>\<CR>\\end{customsol}<++>", 'tex')
call IMAP('csol[]::', "\\begin{customsol}{<++>}[<++>]\<CR><++>\<CR>\\end{customsol}<++>", 'tex')
call IMAP('cbsol::', "\\begin{customboxsol}{<++>}\<CR><++>\<CR>\\end{customboxsol}<++>", 'tex')
call IMAP('bsol::', "\\begin{boxsol}\<CR><++>\<CR>\\end{boxsol}<++>", 'tex')
call IMAP('sol::', "\\begin{solution}\<CR><++>\<CR>\\end{solution}<++>", 'tex')
call IMAP('sol[]::', "\\begin{solution}[<++>]\<CR><++>\<CR>\\end{solution}<++>", 'tex')
call IMAP('cenv::', "\\begin{customenv}{<++>}\<CR><++>\<CR>\\end{customenv}<++>", 'tex')
call IMAP('cenv[]::', "\\begin{customenv}{<++>}[<++>]\<CR><++>\<CR>\\end{customenv}<++>", 'tex')
call IMAP('cprob::', "\\begin{customprob}{<++>}\<CR><++>\<CR>\\end{customprob}<++>", 'tex')
call IMAP('cprob[]::', "\\begin{customprob}{<++>}[<++>]\<CR><++>\<CR>\\end{customprob}<++>", 'tex')
call IMAP('cbprob::', "\\begin{customboxprob}{<++>}\<CR><++>\<CR>\\end{customboxprob}<++>", 'tex')
call IMAP('cbprob[]::', "\\begin{customboxprob}{<++>}[<++>]\<CR><++>\<CR>\\end{customboxprob}<++>", 'tex')
call IMAP('bprob::', "\\begin{boxprob}\<CR><++>\<CR>\\end{boxprob}<++>", 'tex')
call IMAP('bprob[]::', "\\begin{boxprob}[<++>]\<CR><++>\<CR>\\end{boxprob}<++>", 'tex')
call IMAP('brprob::', "\\begin{boxrprob}\<CR><++>\<CR>\\end{boxrprob}<++>", 'tex')
call IMAP('bgprob::', "\\begin{boxgprob}\<CR><++>\<CR>\\end{boxgprob}<++>", 'tex')
call IMAP('Bprob::', "\\begin{boxprob*}\<CR><++>\<CR>\\end{boxprob*}<++>", 'tex')
call IMAP('Bprob[]::', "\\begin{boxprob*}[<++>]\<CR><++>\<CR>\\end{boxprob*}<++>", 'tex')
call IMAP('prob::', "\\begin{problem}\<CR><++>\<CR>\\end{problem}<++>", 'tex')
call IMAP('prob[]::', "\\begin{problem}[<++>]\<CR><++>\<CR>\\end{problem}<++>", 'tex')
call IMAP('thmd::', "\\begin{theoremdef}\<CR><++>\<CR>\\end{theoremdef}<++>", 'tex')
call IMAP('thmd[]::', "\\begin{theoremdef}[<++>]\<CR><++>\<CR>\\end{theoremdef}<++>", 'tex')
call IMAP('Bthm::', "\\begin{boxthm*}\<CR><++>\<CR>\\end{boxthm*}<++>", 'tex')
call IMAP('Bthm[]::', "\\begin{boxthm*}[<++>]\<CR><++>\<CR>\\end{boxthm*}<++>", 'tex')
call IMAP('cthm::', "\\begin{customthm}{<++>}\<CR><++>\<CR>\\end{customthm}<++>", 'tex')
call IMAP('cthm[]::', "\\begin{customthm}{<++>}[<++>]\<CR><++>\<CR>\\end{customthm}<++>", 'tex')
call IMAP('cbthm::', "\\begin{customboxthm}{<++>}\<CR><++>\<CR>\\end{customboxthm}<++>", 'tex')
call IMAP('cbthm[]::', "\\begin{customboxthm}{<++>}[<++>]\<CR><++>\<CR>\\end{customboxprob}<++>", 'tex')
call IMAP('bthm::', "\\begin{boxthm}\<CR><++>\<CR>\\end{boxthm}<++>", 'tex')
call IMAP('bthm[]::', "\\begin{boxthm}[<++>]\<CR><++>\<CR>\\end{boxthm}<++>", 'tex')
call IMAP('thm::', "\\begin{theorem}\<CR><++>\<CR>\\end{theorem}<++>", 'tex')
call IMAP('thm[]::', "\\begin{theorem}[<++>]\<CR><++>\<CR>\\end{theorem}<++>", 'tex')
call IMAP('bcoro::', "\\begin{boxcoro}\<CR><++>\<CR>\\end{boxcoro}<++>", 'tex')
call IMAP('bcoro[]::', "\\begin{boxcoro}[<++>]\<CR><++>\<CR>\\end{boxcoro}<++>", 'tex')
call IMAP('bcl::', "\\begin{boxclaim}\<CR><++>\<CR>\\end{boxclaim}<++>", 'tex')
call IMAP('Bcl::', "\\begin{boxclaim*}\<CR><++>\<CR>\\end{boxclaim*}<++>", 'tex')
call IMAP('icl::', "\\begin{iclaim}\<CR><++>\<CR>\\end{iclaim}<++>", 'tex')
call IMAP('Icl::', "\\begin{iclaim*}\<CR><++>\<CR>\\end{iclaim*}<++>", 'tex')
call IMAP('cl::', "\\begin{claim}\<CR><++>\<CR>\\end{claim}<++>", 'tex')
call IMAP('blem::', "\\begin{boxlemma}\<CR><++>\<CR>\\end{boxlemma}<++>", 'tex')
call IMAP('blem[]::', "\\begin{boxlemma}[<++>]\<CR><++>\<CR>\\end{boxlemma}<++>", 'tex')
call IMAP('lem::', "\\begin{lemma}\<CR><++>\<CR>\\end{lemma}<++>", 'tex')
call IMAP('lem[]::', "\\begin{lemma}[<++>]\<CR><++>\<CR>\\end{lemma}<++>", 'tex')
call IMAP('cbdef::', "\\begin{customboxdef}{<++>}\<CR><++>\<CR>\\end{customboxdef}<++>", 'tex')
call IMAP('cbdef[]::', "\\begin{customboxdef}{<++>}[<++>]\<CR><++>\<CR>\\end{customboxdef}<++>", 'tex')
call IMAP('bdef::', "\\begin{boxdef}\<CR><++>\<CR>\\end{boxdef}<++>", 'tex')
call IMAP('bdef[]::', "\\begin{boxdef}[<++>]\<CR><++>\<CR>\\end{boxdef}<++>", 'tex')
call IMAP('def::', "\\begin{definition}\<CR><++>\<CR>\\end{definition}<++>", 'tex')
call IMAP('def[]::', "\\begin{definition}[<++>]\<CR><++>\<CR>\\end{definition}<++>", 'tex')
call IMAP('cbalgo::', "\\begin{customboxalgo}\<CR><++>\<CR>\\end{customboxalgo}<++>", 'tex')
call IMAP('cbalgo[]::', "\\begin{customboxalgo}{<++>}[<++>]\<CR><++>\<CR>\\end{customboxalgo}<++>", 'tex')
call IMAP('balgo::', "\\begin{boxalgo}\<CR><++>\<CR>\\end{boxalgo}<++>", 'tex')
call IMAP('balgo[]::', "\\begin{boxalgo}[<++>]\<CR><++>\<CR>\\end{boxalgo}<++>", 'tex')
call IMAP('Balgo::', "\\begin{boxalgo*}\<CR><++>\<CR>\\end{boxalgo*}<++>", 'tex')
call IMAP('Balgo[]::', "\\begin{boxalgo*}[<++>]\<CR><++>\<CR>\\end{boxalgo*}<++>", 'tex')
call IMAP('algo::', "\\begin{algorithm}\<CR><++>\<CR>\\end{algorithm}<++>", 'tex')
call IMAP('algo[]::', "\\begin{algorithm}[<++>]\<CR><++>\<CR>\\end{algorithm}<++>", 'tex')
call IMAP('bexmp::', "\\begin{boxexample}\<CR><++>\<CR>\\end{boxexample}<++>", 'tex')
call IMAP('bexmp[]::', "\\begin{boxexample}[<++>]\<CR><++>\<CR>\\end{boxexample}<++>", 'tex')
call IMAP('wt::', "\\begin{walkthrough}\<CR><++>\<CR>\\end{walkthrough}<++>", 'tex')
call IMAP('sh::', "\\begin{shell}\<CR><++>\<CR>\\end{shell}<++>", 'tex')
call IMAP('bwarn::', "\\begin{boxwarn}\<CR><++>\<CR>\\end{boxwarn}<++>", 'tex')
call IMAP('bnote::', "\\begin{boxnote}\<CR><++>\<CR>\\end{boxnote}<++>", 'tex')

call IMAP('sc::', "\\setcounter{<++>}{<++>}<++>", 'tex')
call IMAP('sc0::', "\\setcounter{<++>}0<++>", 'tex')

