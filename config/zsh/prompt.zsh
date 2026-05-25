setopt PROMPT_SUBST

export VIRTUAL_ENV_DISABLE_PROMPT=1

SEP=""
GIT_ICON=""
PY_ICON=""

segment() {
  local bg="$1"
  local fg="$2"
  local text="$3"
  local next_bg="$4"

  if [[ -n "$text" ]]; then
    print -rn "%K{$bg}%F{$fg} ${text} %k%F{$bg}%K{$next_bg}${SEP}%f%k"
  fi
}

last_segment() {
  local bg="$1"
  local fg="$2"
  local text="$3"

  if [[ -n "$text" ]]; then
    print -rn "%K{$bg}%F{$fg} ${text} %k%F{$bg}${SEP}%f%k"
  fi
}

git_branch_name() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  local git_status
  git_status=$(git status --porcelain 2>/dev/null)

  local markers=""

  if echo "$git_status" | grep -q "^[ MARC][MD]"; then
    markers+="*"
  fi

  if echo "$git_status" | grep -qE "^[ A][AM]|^\?\?"; then
    markers+="+"
  fi

  if echo "$git_status" | grep -q "^[ D][ D]"; then
    markers+="-"
  fi

  print -r "${GIT_ICON} ${branch}${markers}"
}

venv_name() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    print -r "${PY_ICON} $(basename "$VIRTUAL_ENV")"
  fi
}

precmd() {
  local user_host="%n@%m"
  local cwd="%~"
  local git="$(git_branch_name)"
  local venv="$(venv_name)"

  PROMPT=""

  if [[ -n "$git" && -n "$venv" ]]; then
    PROMPT+="$(segment 86 16 "$user_host" 69)"
    PROMPT+="$(segment 69 16 "$cwd" 39)"
    PROMPT+="$(segment 39 16 "$git" 220)"
    PROMPT+="$(last_segment 220 16 "$venv")"

  elif [[ -n "$git" ]]; then
    PROMPT+="$(segment 86 16 "$user_host" 69)"
    PROMPT+="$(segment 69 16 "$cwd" 39)"
    PROMPT+="$(last_segment 39 16 "$git")"

  elif [[ -n "$venv" ]]; then
    PROMPT+="$(segment 86 16 "$user_host" 69)"
    PROMPT+="$(segment 69 16 "$cwd" 220)"
    PROMPT+="$(last_segment 220 16 "$venv")"

  else
    PROMPT+="$(segment 86 16 "$user_host" 69)"
    PROMPT+="$(last_segment 69 16 "$cwd")"
  fi

  PROMPT+=" "
}
