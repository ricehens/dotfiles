# Homebrew setup
if [[ $(uname -m) == 'arm64' ]]; then
    BREWPATH=/opt/homebrew/bin
else
    BREWPATH=/usr/local/bin
fi
export PATH=$BREWPATH:$PATH
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

alias syu='brew update && brew upgrade --ignore-pinned --formula'

# Vim
export VISUAL='nvim'
export EDITOR='nvim'
# Custom scripts
typeset -U PATH path
export PATH=/Users/ericshen/bin:/Users/ericshen/.local/bin:$PATH
export PYTHONPATH=/Users/ericshen/.von:$PATH

# Java PATH
# export PATH="/usr/lib/jvm/java-14-openjdk/bin:$PATH"

# Useful constants
export SITE='eh2z5z1c0mo2@ericshen.net'
export ATH='eys@athena.dialup.mit.edu'
export MW='/Users/ericshen/Documents/Classes/LiJie'
export SCH='/Users/ericshen/Dropbox (MIT)/MIT-2025'
export MIT='/Users/ericshen/Dropbox (MIT)'

# Cleanup
alias clean='rm *.aux *.fdb_latexmk *.fls *.log *.out *.pre *.class *.von *.mcgrep *~' 
alias cleanl='ls *.aux *.fdb_latexmk *.fls *.log *.out *.pre *.class *.von *.mcgrep *~' 
alias cleanf='rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.pre *.class *.von *.mcgrep *~' 
setopt +o nomatch

# ls preferences
# alias ls='ls --color=tty --group-directories-first --quoting-style=literal -CF --time-style=long-iso'
alias ls='ls -GCF -a'
alias ll='ls -lh'
# alias la='ls -a'
alias l='ls -alh'

# git
alias g='git'

# Be careful
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Fun!
alias what='ping -c 3 google.com'
# alias rvim='sudo -E vim' # sudo vim while preserving environment
alias shrug='echo "¯\_(ツ)_/¯"'

# Useful
alias pdf='zathura &>/dev/null'

# I'm lazy so http://bashrcgenerator.com/
#export PS1="\[$(tput bold)\]\[\033[38;5;43m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;38m\]@\[$(tput sgr0)\]\[\033[38;5;80m\]\h\[$(tput sgr0)\]\[\033[38;5;38m\]:\[$(tput bold)\]\[\033[38;5;45m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;38m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
# zsh PS1
PROMPT="%F{86}%n%F{75}@%F{87}%m%F{75}:%F{69}%~%F{75}$%f "

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

# Do not auto update homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# GCC
alias gcc="/opt/homebrew/bin/gcc-14"
alias g++="/opt/homebrew/bin/g++-14"

# von
alias von="python3 -m von"
# Python
# alias python="python3.11"
# alias idle="idle3.11"

## make zsh more like bash
# back and forward word cut by slashes
autoload -U select-word-style
select-word-style bash
# autocomplete
setopt noautomenu
setopt nomenucomplete

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# du --max-depth=1
alias du1="du -hd1"

# dbus setup (for vimtex-zathura interaction)
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
export MY_SESSION_BUS_SOCKET="/tmp/dbus/$USER.session.usock"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
