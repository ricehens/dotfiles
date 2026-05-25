bindkey -e

setopt +o nomatch
autoload -U select-word-style
select-word-style bash
setopt noautomenu
setopt nomenucomplete

# fzf
source <(fzf --zsh)
bindkey -s '^Z' "fzf --bind 'enter:become(nvim {})'\n"


