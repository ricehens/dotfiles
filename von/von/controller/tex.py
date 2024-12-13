from .. import model, view
import os

#parser.add_argument('-f', '--filename', default = None,
#		help="Filename for the file to produce (defaults to po.tex).")

def main(self, argv):
	if not os.path.exists("/tmp/preview/"):
		os.mkdir("/tmp/preview")
	with open("/tmp/preview/von_preview.tex", "w") as f:
		print(r"\documentclass[11pt]{scrartcl}", file=f)
		print(r"\usepackage[default]{shen}", file=f)
		print(r"\title{VON Preview}", file=f)
		print(r"\begin{document}", file=f)
		print(r"<++>", file=f)
		print(r"\end{document}", file=f)
	cwd = model.getCompleteCwd()
	os.chdir("/tmp/preview")
	os.system("latexmk -pvc -pdf /tmp/preview/von_preview.tex &>/dev/null &")
	os.chdir(cwd)

