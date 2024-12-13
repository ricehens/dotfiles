from .. import model, view
import os

parser = view.Parser(prog='blog',\
		description='Prepares a blog post.')
parser.add_argument('keys', nargs = '+',
		help="The keys of the problem to propose.")
parser.add_argument('-k', '--sourced', action = 'store_const',
		const = False, default = True,
		help="Hide the source.")
parser.add_argument('-f', '--filename', default = None,
		help="Filename for the file to produce (defaults to po.tex).")

LATEX_PREAMBLE = r"""
"""

def main(self, argv):
	opts = parser.process(argv)
	s = ""

	for key in opts.keys:
		entry = model.getEntryByKey(key)
		if entry is None:
			view.error(key + " not found")
		elif entry.secret and not opts.brave:
			view.error("Problem `%s` not shown without --brave" %entry.source)
			return
		else:
			problem = entry.full
			s += r"[b]Problem" 
			if opts.sourced:
				s += " (" + entry.source + ")"
			s += ".[/b] "
			s += model.toAOPS(problem.bodies[0]) + ""
#			s += "\n" + r"\hrulebar" + "\n\n"
			s += "\n[hide=(Solution)]\n"
			s += model.toAOPS(problem.bodies[1]) + ""
			s += r"[/hide]" + "\n\n"
	else:
		if opts.filename is not None:
			fname = opts.filename
		else:
			fname = 'blog'
		if not os.path.exists("/tmp/po/"):
			os.mkdir("/tmp/po")
		with open("/tmp/po/%s.txt" %fname, "w") as f:
			print(s, file=f)
