from .. import model, view
import os

parser = view.Parser(prog='po',\
		description='Prepares a LaTeX file to send to Po-Shen!')
parser.add_argument('keys', nargs = '+',
		help="The keys of the problem to propose.")
parser.add_argument('-t', '--title', default = None,
		help="Title of the LaTeX document.")
parser.add_argument('-s', '--subtitle', default = None,
		help="Subtitle of the LaTeX document.")
parser.add_argument('--author', default = 'Eric Shen',
		help="Author of the LaTeX document.")
parser.add_argument('--date', default = r'\today',
		help="Date of the LaTeX document.")
parser.add_argument('-k', '--sourced', action = 'store_const',
		const = False, default = True,
		help="Hide the source.")
parser.add_argument('--tex', action='store_const',
		const = True, default = False,
		help="Supply only the TeX source, rather than compiling to PDF.")
parser.add_argument('-f', '--filename', default = None,
		help="Filename for the file to produce (defaults to po.tex).")

LATEX_PREAMBLE = r"""
\usepackage[default]{shen}
"""

def main(self, argv):
	opts = parser.process(argv)

	# Better default title:
	if opts.title is not None:
		title = opts.title
	elif len(opts.keys) == 1:
		entry = model.getEntryByKey(opts.keys[0])
		if entry is not None:
			title = entry.source
		else:
			title = "Solution"
	else:
		title = "Solutions"

	s = r"\documentclass[10pt]{article}" + "\n"
	s += LATEX_PREAMBLE.replace("AUTHOR", opts.author).replace("TITLE", title)
	s += r"\begin{document}" + "\n"
	s += r"\title{\vspace{-2em}" + title + "}" + "\n"
	if opts.subtitle is not None:
		s += r"\subtitle{" + opts.subtitle + "}" + "\n"
	s += r"\author{" + opts.author + "}" + "\n"
	s += r"\date{" + opts.date + "}" + "\n"
	s += r"\maketitle" + "\n"
	s += "\n"
	for key in opts.keys:
		entry = model.getEntryByKey(key)
		if entry is None:
			view.error(key + " not found")
		elif entry.secret and not opts.brave:
			view.error("Problem `%s` not shown without --brave" %entry.source)
			return
		else:
			problem = entry.full
			s += r"\begin{boxprob}" if len(opts.keys) > 1 \
					else r"\begin{boxprob*}"
			if opts.sourced:
				s += "[" + entry.source + "]"
			s += "\n"
			s += model.demacro(problem.bodies[0]) + "\n"
			s += r"\end{boxprob}" if len(opts.keys) > 1 \
					else r"\end{boxprob*}"
#			s += "\n" + r"\hrulebar" + "\n\n"
			s += "\n"
			s += model.demacro(problem.bodies[1]) + "\n"
			s += r"\newpage" + "\n\n"
	s += r"\end{document}"
	if opts.tex:
		view.out(s)
	else:
		if opts.filename is not None:
			fname = opts.filename
		elif len(opts.keys) == 1:
			fname = view.file_escape(title)
		else:
			fname = 'po'
		if not os.path.exists("/tmp/po/"):
			os.mkdir("/tmp/po")
		with open("/tmp/po/%s.tex" %fname, "w") as f:
			print(s, file=f)
		os.chdir('/tmp/po')
		os.system("latexmk -pv /tmp/po/%s.tex;" %fname)
