# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

function is() {
  if [[ "$(echo $(uname) | tr '[:upper:]' '[:lower:]')" == "${1}" ]]; then
    return 0
  else
    return 1
  fi
}

function has() {
  if hash "${1}" 2> /dev/null; then
    return 0
  else
    return 1
  fi
}

function inline() {
  echo "${1}" | tr -d '\n' | sed -e 's/^ *//' -e 's/ \{2,\}/ /g'
}

# ------------------------------------------------------------------------------
# System
# ------------------------------------------------------------------------------

if has brew; then
  alias bu='brew update && brew upgrade && brew cleanup'
fi

if has open; then
  alias o=open
  alias .='open .'
fi

# ------------------------------------------------------------------------------
# Terminal
# ------------------------------------------------------------------------------

if is darwin || is linux; then
  export PS1=$(inline '
    \[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h
    \[\033[01;34m\]\W \$\[\033[00m\] ')
fi

if is linux; then
  export LS_COLORS=$(echo '
    di=35;40: ln=36;40: so=32;40: pi=33;40: ex=31;40: bd=34;46:
    cd=34;43: su= 0;41: sg= 0;46: tw= 0;42: ow= 0;43:' | tr -d '\n ')
  alias ls='ls --color=auto'
fi

if is darwin; then
  export CLICOLOR=1
  export LSCOLORS=fxgxcxdxbxegedabagacad
  alias ls='ls -G'
fi

alias grep='grep --color=auto'

export HISTFILESIZE=''
export HISTSIZE=''
shopt -s histappend

case "${TERM}" in
rxvt*|screen*|xterm*)
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
  bind '"\e[1;5D": backward-word'
  bind '"\e[1;5C": forward-word'
  ;;
esac

if has tmux; then
  alias t='tmux attach || tmux new'
fi

# ------------------------------------------------------------------------------
# Editor
# ------------------------------------------------------------------------------

export EDITOR=vim
export VISUAL=vim
alias v=vim

if is darwin && has mvim; then
  alias v=mvim
fi

# ------------------------------------------------------------------------------
# Version control
# ------------------------------------------------------------------------------

if has git; then
  alias g=git
  alias ga='git add'
  alias gap='git add --patch'
  alias gb='git branch'
  alias gc='git commit'
  alias gca='git commit --amend'
  alias gco='git checkout'
  alias gd='git diff'
  alias gds='git diff --staged'
  alias gg='git grep --line-number'
  alias gi='git submodule update --init'
  alias gl='git log'
  alias gp='git push'
  alias gpl='git pull'
  alias gs='git status'
fi

if has git && has brew; then
  file=$(brew --prefix)/etc/bash_completion.d/git-prompt.sh
  [ -f "${file}" ] && source "${file}"

  file=$(brew --prefix)/etc/bash_completion.d/git-completion.bash
  [ -f "${file}" ] && source "${file}"
fi

if (is darwin || is linux) && has __git_ps1; then
  export PS1=$(inline '
    \[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h
    \[\033[01;34m\]\W$(__git_ps1 " [\[\033[01;36m\]%s\[\033[01;34m\]]")
    \$\[\033[00m\] ')
fi

# ------------------------------------------------------------------------------
# Programming
# ------------------------------------------------------------------------------

if has ag; then
  alias agc='ag -A1 -B1'
fi

if has cargo; then
  alias c=cargo
  alias cob='cargo bench'
  alias cod='cargo doc --open'
  alias cot='cargo test --jobs 1'
  alias cou='cargo update'
fi

if has docker; then
  alias d=docker
fi

if has go; then
  alias gob='go test -bench .'
  alias gof='go fmt .'
  alias got='go test'
fi

if has make; then
  alias m=make
fi

if has rustup; then
  alias rsu='rustup update nightly'
fi

if has yapf; then
  alias pyf='yapf --style=google --in-place --recursive'
fi
