#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

# Custom scripts
export VISUAL='vim'
export EDITOR='vim'
export PATH="~/Scripts:$PATH"

# Java PATH
export PATH="/usr/lib/jvm/default-runtime/bin:$PATH"

# Allow opacity in ASY
alias asy='asy -nosafe'

# Cleanup
alias clean='rm *.aux *.fdb_latexmk *.fls *.log *.out *.pre *.class'

# Terminal Emacs
alias tmacs='emacs -nw'

# Fun!
alias please='sudo $(fc -ln -1)'
alias dog='pygmentize -g'
alias what='ping -c 3 google.com'

# --------------
# Color terminal
# --------------
# I'm lazy so http://bashrcgenerator.com/
export PS1="\[$(tput bold)\]\[\033[38;5;43m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;38m\]@\[$(tput sgr0)\]\[\033[38;5;80m\]\h\[$(tput sgr0)\]\[\033[38;5;38m\]:\[$(tput bold)\]\[\033[38;5;45m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;38m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
