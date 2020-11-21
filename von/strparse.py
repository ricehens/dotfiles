import re

# Demacro
def demacro(text):
	# TODO this doesn't quite work, but oh well
	replacements = [
		(r"\da", r"\measuredangle"),
		(r"\cycsum", r"\sum_\mathrm{cyc}"),
		(r"\symsum", r"\sum_\mathrm{sym}"),
		(r"\cycprod", r"\prod_\mathrm{cyc}"),
		(r"\symprod", r"\prod_\mathrm{sym}"),
		(r"\ray", r"\overrightarrow"),
		(r"\seg", r"\overline"),
		(r"\defeq", r"\overset{\mathrm{def}}{=}"),
		(r"\dg", r"^\circ"),
		(r"\opname", r"\operatorname"),
		(r"\ii", r"\item"),
		(r"\lcm", r"\operatorname{lcm}"),
		(r"\cis", r"\operatorname{cis}"),
		(r"\ord", r"\operatorname{ord}"),
		(r"\pow", r"\operatorname{Pow}"),
		(r"\rad", r"\operatorname{rad}"),
		(r"\vphi", r"\varphi"),
		(r"\veps", r"\varepsilon"),
	]
	s = text
	for short, full in replacements:
		s = s.replace(short, full)
	return s

def toAOPS(text):
	text = demacro(text)
	text = text.replace(r"\begin{asy}", "[asy]")
	text = text.replace(r"\end{asy}", "[/asy]")
	text = text.replace(r"\begin{center}", "\n")
	text = text.replace(r"\end{center}", "\n")
	text = text.replace(r"\pagebreak", "\n\n")
	text = text.replace(r"\newpage", "\n\n")
	text = text.replace(r"\par ", "\n\n")
	text = text.replace(r"\item ", "[*]")
	text = text.replace(r"\begin{solution}", r"[b]Solution.[/b]")
	text = text.replace(r"\end{solution}", "")
	text = text.replace(r"\end{customsol}", "")
	text = text.replace(r"\end{customenv}", "")
	text = text.replace(r"itemsep=0em,", r"")
	text = text.replace(r",itemsep=0em", r"")
	text = text.replace(r"[itemsep=0em]", r"")
	text = text.replace(r"\begin{enumerate}[label=(\alph*)]", "[list=a]")
	text = text.replace(r"\begin{enumerate}[label=\alph*.]", "[list=a]")
	text = text.replace(r"\begin{enumerate}[label=(\roman*)]", "[list=i]")
	text = text.replace(r"\begin{enumerate}[label=\roman*.]", "[list=i]")
	text = text.replace(r"\begin{enumerate}[]", "[list=1]")
	text = text.replace(r"\begin{enumerate}", "[list=1]")
	text = text.replace(r"\end{enumerate}", "[/list]")
	text = text.replace(r"\begin{itemize}", "[list]")
	text = text.replace(r"\end{itemize}", "[/list]")
	text = text.replace(r"{boxgprob", r"{generalization")
	text = text.replace(r"{boxrprob", r"{restated problem")
	text = text.replace(r"{boxprob", r"{problem")
	text = text.replace(r"{boxthm", r"{theorem")
	text = text.replace(r"{boxclaim", r"{claim")
	text = text.replace(r"{iclaim", r"{claim")
	text = text.replace(r"{boxlemma", r"{lemma")
	text = text.replace(r"{boxcoro", r"{corollary")
	text = text.replace(r"{boxremark", r"{remark")
	#text = text.replace(r"\#", "#")
	text = text.replace("%\n", "\n") # strip trailing percent signs

	text = re.sub(r"\\begin{([^}]*)}\[([^\]]*)\]" + "\n", r"\\begin{\1}" + "\n" + r"[\2] ", text)
	for env in ['theorem', 'claim', 'lemma', 'proposition', 'corollary', 'definition',\
			'remark', 'generalization', 'restated problem']:
		text = re.sub(r"\\begin{" + env + "\*}", "\n[color=red][b]" + env.title() + r":[/b][/color] ", text)
		text = re.sub(r"\\end{" + env + "\*}", "", text)
		text = re.sub(r"\\begin{" + env + "}", "\n[color=red][b]" + env.title() + r":[/b][/color] ", text)
		text = re.sub(r"\\end{" + env + "}", "", text)
	text = text.replace(r"\begin{proof}", "\n[i]Proof.[/i] ")
	text = text.replace(r"\end{proof}", r"$\blacksquare$" + "\n")
	# Remove Asy opacities, doesn't work on AoPS
	text = re.sub(r"=([^,=]+)\+opacity\(0.[0-9]+\);", "=invisible;", text)
	# Replace \emph, \textit, et al
	text = re.sub(r"\\emph{([^}]*)}", r"[i]\1[/i]", text)
	text = re.sub(r"\\textit{([^}]*)}", r"[i]\1[/i]", text)
	text = re.sub(r"\\textbf{([^}]*)}", r"[b]\1[/b]", text)
	text = re.sub(r"\\paragraph{([^}]*)}", r"[color=blue][b]\1[/b][/color]", text)
	text = re.sub(r"\\url{([^}]*)}", r"[url]\1[/url]", text)
	text = re.sub(r"\\href{([^}]*)}{([^}]*)}", r"[url=\1]\2[/url]", text)
	text = re.sub(r"\\setcounter{([^}]*)}{([^}]*)}", r"", text)
	text = re.sub(r"\\setcounter{([^}]*)}([^\n]*)", r"", text)

	# Textstyle :p
	text = re.sub(r"\$([^\$]+)\$", r"\\(\1\\)", text)

	# Join together newlines
	paragraphs = [_.strip().replace("\n", " ") for _ in text.split('\n\n')]
	return '\n\n'.join(paragraphs)

def toHTML(text):
	paragraphs = re.split(r"\\begin{center}\s*\\begin{asy}|\\end{asy}\s*\\end{center}", text)
	for i in range(0, len(paragraphs), 2):
		paragraphs[i] = toHTML0(paragraphs[i])
	for i in range(1, len(paragraphs), 2):
		paragraphs[i] = '<p>\\begin{center}\\begin{asy}\n' + paragraphs[i] + '\n\\end{asy}\\end{center}</p>'
	return '\n\n'.join(paragraphs)


def toHTML0(text):
	text = demacro(text)
	text = text.replace(r"\begin{center}", "<center>")
	text = text.replace(r"\end{center}", "</center>")
	text = text.replace(r"\pagebreak", "\n\n")
	text = text.replace(r"\newpage", "\n\n")
	text = text.replace(r"\par ", "\n\n")
	text = text.replace(r"\item ", "<li>")
	text = text.replace(r"\begin{solution}", r"<b>Solution.</b>")
	text = text.replace(r"\end{solution}", "")
	text = text.replace(r"\end{customsol}", "")
	text = text.replace(r"\end{customenv}", "")
	text = text.replace(r"itemsep=0em,", r"")
	text = text.replace(r",itemsep=0em", r"")
	text = text.replace(r"[itemsep=0em]", r"")
	text = text.replace(r"\begin{enumerate}[label=(\alph*)]", "<ol type=\"a\">")
	text = text.replace(r"\begin{enumerate}[label=\alph*.]", "<ol type=\"a\">")
	text = text.replace(r"\begin{enumerate}[label=(\roman*)]", "<ol type=\"i\">")
	text = text.replace(r"\begin{enumerate}[label=\roman*.]", "<ol type=\"i\">")
	text = text.replace(r"\begin{enumerate}[]", "<ol>")
	text = text.replace(r"\begin{enumerate}", "<ol>")
	text = text.replace(r"\end{enumerate}", "</ol>")
	text = text.replace(r"\begin{itemize}", "<ul>")
	text = text.replace(r"\end{itemize}", "</ul>")
	text = text.replace(r"{boxgprob", r"{generalization")
	text = text.replace(r"{boxrprob", r"{restated problem")
	text = text.replace(r"{boxprob", r"{problem")
	text = text.replace(r"{boxthm", r"{theorem")
	text = text.replace(r"{boxclaim", r"{claim")
	text = text.replace(r"{iclaim", r"{claim")
	text = text.replace(r"{boxlemma", r"{lemma")
	text = text.replace(r"{boxcoro", r"{corollary")
	text = text.replace(r"{boxremark", r"{remark")
	text = text.replace(r"\#", "#")
	text = text.replace("%\n", "\n") # strip trailing percent signs

	text = re.sub(r"\\begin{([^}]*)}\[([^\]]*)\]" + "\n", r"\\begin{\1}" + "\n" + r"[\2] ", text)
	for env in ['theorem', 'claim', 'lemma', 'proposition', 'corollary', 'definition',\
			'remark', 'generalization', 'restated problem']:
		text = re.sub(r"\\begin{" + env + "\*}", "\n\n<span style=\"color:red; font-weight:bold;\">" + env.title() + r":</span> ", text)
		text = re.sub(r"\\end{" + env + "\*}", "", text)
		text = re.sub(r"\\begin{" + env + "}", "\n\n<span style=\"color:red; font-weight:bold;\">" + env.title() + r":</span> ", text)
		text = re.sub(r"\\end{" + env + "}", "", text)
	text = re.sub(r"\\begin{proof}", "\n\n<i>Proof.</i> ", text)
	text = re.sub(r"\\end{proof}", r"$\\blacksquare$" + "\n", text)
	# Remove Asy opacities, doesn't work on AoPS; actually asy doesn't work in HTML :p
	# text = re.sub(r"=([^,=]+)\+opacity\(0.[0-9]+\);", "=invisible;", text)
	# Replace \emph, \textit, et al
	text = re.sub(r"\\emph{([^}]*)}", r"<i>\1</i>", text)
	text = re.sub(r"\\textit{([^}]*)}", r"<i>\1</i>", text)
	text = re.sub(r"\\textbf{([^}]*)}", r"<b>\1</b>", text)
	text = re.sub(r"\\paragraph{([^}]*)}", r"<span style=\"color:blue; font-weight:bold;\">\1</span>", text)
	text = re.sub(r"\\url{([^}]*)}", r"<a href=\"\1\" target=\"blank\">\1</a>", text)
	text = re.sub(r"\\href{([^}]*)}{([^}]*)}", r"<a href=\"\1\" target=\"blank\">\2</a>", text)
	text = re.sub(r"\\begin{customsol}{([^}]*)}", "\n\n" + "<span style=\"color:blue; font-weight:bold;\">" + r"Solution \1." + "</span> ", text)
	text = re.sub(r"\\begin{customenv}{([^}]*)}", "\n\n" + "<span style=\"color:blue; font-weight:bold;\">" + r"\1." + "</span> ", text)
	text = re.sub(r"\\setcounter{([^}]*)}{([^}]*)}", r"", text)
	text = re.sub(r"\\setcounter{([^}]*)}([^\n]*)", r"", text)

	# Join together newlines
	paragraphs = [_.strip().replace("\n", " ") for _ in text.split('\n\n')]
	return '<p>' + '</p>\n\n<p>'.join(paragraphs) + '</p>'

