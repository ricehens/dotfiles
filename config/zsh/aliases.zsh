alias syu='brew update && brew upgrade --ignore-pinned --formula'

alias ls='ls -GCF -a'
alias ll='ls -lh'
alias l='ls -alh'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias g='git'
alias nvimdiff='nvim -d'

alias dog='pygmentize -g -O style=nord'
alias ip='ipconfig getifaddr en0'
alias pdf='zathura &>/dev/null'
alias fim='llama-server --fim-qwen-3b-default'

alias english='export LANG=en_US.utf8'
alias chinese='export LANG=zh_CN.utf8'

alias short='precmd() { PROMPT="$(venv_name)%F{75}$%f " }'

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

# homebrew gcc
alias gcc="/opt/homebrew/bin/gcc-15"
alias g++="/opt/homebrew/bin/g++-15"
# export CC="/opt/homebrew/bin/gcc-15"
# export CXX="/opt/homebrew/bin/g++-15"
# export CC=/opt/homebrew/opt/llvm/bin/clang
# export CXX=/opt/homebrew/opt/llvm/bin/clang++

# du --max-depth=1
alias du1="du -hd1"

# compress recording
alias mov2vt='f(){ 
    in="$1"
    out="${in%.*}.mp4"
    ffmpeg -i "$in" -vcodec h264_videotoolbox -b:v 2M -acodec flac "$out"
}; f'


