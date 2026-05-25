if [[ $(uname -m) == 'arm64' ]]; then
    BREWPATH=/opt/homebrew/bin
else
    BREWPATH=/usr/local/bin
fi
export PATH=$BREWPATH:$PATH
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

alias syu='brew update && brew upgrade --ignore-pinned --formula'

export HOMEBREW_NO_AUTO_UPDATE=1

export VISUAL='nvim'
export EDITOR='nvim'

typeset -U PATH path
export PATH=/Users/ericshen/bin:/Users/ericshen/.local/bin:$PATH

setopt +o nomatch
autoload -U select-word-style
select-word-style bash
setopt noautomenu
setopt nomenucomplete

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

# modify precmd
function git_branch_name() {
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  local color="%F{39}"
  local git_status=$(git status --porcelain 2>/dev/null)
  if echo "$git_status" | grep -q "^\s\?M"; then
    branch="${branch}*"
  fi
  if echo "$git_status" | grep -qE "^\s\?A|^\?\?"; then
    branch="${branch}+"
  fi
  if echo "$git_status" | grep -q "^\s\?D"; then
    branch="${branch}-"
  fi

  if [[ -n "$branch" ]]; then
    branch="${color} (${branch})"
  fi

  echo $branch
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
function venv_name() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    print -r "%F{220}($(basename "$VIRTUAL_ENV"))%f "
  fi
}

precmd() {
    PROMPT="$(venv_name)%F{86}%n%F{75}@%F{87}%m%F{75}:%F{69}%~%F{75}$(git_branch_name)%F{75}$%f "
}
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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# du --max-depth=1
alias du1="du -hd1"

# fzf
source <(fzf --zsh)
bindkey -s '^Z' "fzf --bind 'enter:become(nvim {})'\n"

# compress recording
alias mov2vt='f(){ 
    in="$1"
    out="${in%.*}.mp4"
    ffmpeg -i "$in" -vcodec h264_videotoolbox -b:v 2M -acodec flac "$out"
}; f'

# sdkman: java sdk manager
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

