#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '

# Trick jshell into working
export TERM=xterm-256color
# Vim
export VISUAL='vim'
export EDITOR='vim'
# Custom scripts
export PATH="/home/ericshen/bin:$PATH"
export PYTHONPATH="/home/ericshen/.von:$PATH"

# Java PATH
export PATH="/usr/lib/jvm/java-15-jdk/bin:$PATH"

# Useful constants
export SITE='eh2z5z1c0mo2@ericshen.net'
export MW='/home/ericshen/Documents/Classes/LiJie'
export SCH='/home/ericshen/Documents/School/Grade-10'

# Cleanup
alias clean='rm *.aux *.fdb_latexmk *.fls *.log *.out *.pre *.class *.von *.mcgrep *~'

# Useful alternatives
#alias asy='asy -nosafe -noprc -render=0' # THANK YOU GHOSTSCRIPT 9.50 (screw you ghostscript 9.52)
alias tmacs='emacs -nw' # non-graphical emacs
alias pdf='zathura &>/dev/null' # zathura shortcut
alias img='feh --scale-down --auto-zoom' # feh auto-scale
alias ytdl="youtube-dl -f bestaudio[ext=m4a] --embed-thumbnail --add-metadata -o '%(title)s.%(ext)s'" # download music
alias gvim='gvim &>/dev/null' # don't print warnings
alias von='python -m von' # von
alias g='git' # git (e.g. g s, g a)

# ls preferences
alias ls='ls --color=tty --group-directories-first --quoting-style=literal -CF --time-style=long-iso'
alias ll='ls -lh'
alias la='ls -a'
alias l='ls -alh'

# Be careful
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Fun!
alias caps='xdotool key Caps_Lock'
alias CAPS='xdotool key Caps_Lock'
alias fuck='sudo $(fc -ln -1)'
alias dog='pygmentize -g'
alias what='ping -c 3 google.com'
alias rvim='sudo -E vim' # sudo vim while preserving environment
alias shrug='echo "¯\_(ツ)_/¯"'

# Quickly switch locale
alias english='export LANG=en_US.utf8'
alias chinese='export LANG=zh_CN.utf8'

# ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# urxvt ctrl+s flow control is stupid
stty -ixon

# i3blocks
export SCRIPT_DIR='/home/ericshen/.config/i3blocks'

# I'm lazy so http://bashrcgenerator.com/
export PS1="\[$(tput bold)\]\[\033[38;5;43m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;38m\]@\[$(tput sgr0)\]\[\033[38;5;80m\]\h\[$(tput sgr0)\]\[\033[38;5;38m\]:\[$(tput bold)\]\[\033[38;5;45m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;38m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Auto-complete
# source /home/ericshen/bin/auto-complete-alias &>/dev/null

# Copy-pasta; Use:
# $ echo 'Hi' | pclip; gclip
if [ -n "$(type -P xclip)" ]; then
    test -z "$(type -P pclip)"  && \
        alias pclip="$(type -P xclip) -selection c -i"
    test -z "$(type -P gclip)"  && \
        alias gclip="$(type -P xclip) -selection c -o"
    test -z "$(type -P pprim)"  && \
        alias pprim="$(type -P xclip) -selection p -i"
    test -z "$(type -P gprim)"  && \
        alias gprim="$(type -P xclip) -selection p -o"
fi

# Extract files (thanks Reddit)
extract() {
 if [ -f $1 ] ; then
     case $1 in
         *.tar.bz2)   tar xvjf $1    ;;
         *.tar.gz)    tar xvzf $1    ;;
         *.tar.xz)    tar xvJf $1    ;;
         *.bz2)       bunzip2 $1     ;;
         *.rar)       unrar x $1     ;;
         *.gz)        gunzip $1      ;;
         *.tar)       tar xvf $1     ;;
         *.tbz2)      tar xvjf $1    ;;
         *.tgz)       tar xvzf $1    ;;
         *.zip)       unzip $1       ;;
         *.Z)         uncompress $1  ;;
         *.7z)        7z x $1        ;;
         *.xz)        unxz $1        ;;
         *.exe)       cabextract $1  ;;
         *)           echo "\`$1': unrecognized file compression" ;;
     esac
 else
     echo "\`$1' is not a valid file"
 fi
}
