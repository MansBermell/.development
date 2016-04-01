# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

function is() {
  if [[ "$(echo $(uname) | tr '[:upper:]' '[:lower:]')" == "$1" ]]; then
    return 0
  else
    return 1
  fi
}

function has() {
  if hash "$1" 2> /dev/null; then
    return 0
  else
    return 1
  fi
}

function inline() {
  echo "$1" | tr -d '\n' | sed -e 's/^ *//' -e 's/ \{2,\}/ /g'
}

# ------------------------------------------------------------------------------
# Terminal
# ------------------------------------------------------------------------------

if is linux; then
  export LS_COLORS=$(echo '
    di=35;40: ln=36;40: so=32;40: pi=33;40: ex=31;40: bd=34;46:
    cd=34;43: su= 0;41: sg= 0;46: tw= 0;42: ow= 0;43:' | tr -d '\n ')
  alias ls='ls --color=auto'
  alias ll='ls --color=auto -l'
  alias la='ls --color=auto -la'
else
  export CLICOLOR=1
  export LSCOLORS=fxgxcxdxbxegedabagacad
  alias ls='ls -G'
  alias ll='ls -G -l'
  alias la='ls -G -la'
fi

alias grep='grep --color=auto'

export PS1=$(inline '
  \[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h
  \[\033[01;34m\]\W \$\[\033[00m\] ')

export HISTSIZE=''
alias hstats=$(inline '
  history |
  awk '\''{a[$2]++}END{for(i in a){print a[i] " " i}}'\'' |
  LC_ALL=C sort -rn |
  head -20')

case "$TERM" in
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
alias v=vim

if is darwin && has gvim; then
  alias v=gvim
fi

# ------------------------------------------------------------------------------
# Version control
# ------------------------------------------------------------------------------

if has git; then
  for command in '' a ap b c ca cf cl co d ds g l p pl s sp; do
    alias "g$command"="git $command"
  done
fi

if has git && has brew; then
  file=$(brew --prefix)/etc/bash_completion.d/git-prompt.sh
  [ -f "$file" ] && source "$file"

  file=$(brew --prefix)/etc/bash_completion.d/git-completion.bash
  [ -f "$file" ] && source "$file"
fi

if has __git_ps1; then
  export PS1=$(inline '
    \[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h
    \[\033[01;34m\]\W$(__git_ps1 " [\[\033[01;36m\]%s\[\033[01;34m\]]")
    \$\[\033[00m\] ')
fi

# ------------------------------------------------------------------------------
# Programming
# ------------------------------------------------------------------------------

if has make; then
  alias m=make
fi

if has bundle; then
  alias b=bundle
  alias be='bundle exec'
  alias bo='bundle open'
fi

if has bundle && has guard; then
  alias beg='bundle exec guard --clear'
fi

if has rails; then
  alias r=rails
  alias rb=$(inline '
    rails new
      --skip-active-record
      --skip-sprockets
      --skip-spring
      --skip-javascript
      --skip-test-unit
      --skip-bundle')
fi

if has go; then
  alias gob='go test -bench .'
  alias goc=$(inline '
    go test -coverprofile cover.out &&
    go tool cover -html=cover.out -o cover.html &&
    open cover.html')
  alias gof='go fmt .'
  alias got='go test'
fi

if has rustc; then
  alias rsu=$(inline '
    curl https://static.rust-lang.org/rustup.sh -O &&
    chmod +x rustup.sh &&
    ./rustup.sh --prefix=$(dirname $(dirname $(which rustc))) --channel=nightly --disable-sudo --yes  &&
    rm ./rustup.sh')
fi

if has cargo; then
  alias c=cargo
  alias cob='cargo bench'
  alias cot='cargo test'
  alias cou='cargo update'
fi

if has rustfmt; then
  alias rsf='rustfmt --write-mode=overwrite'
fi

# ------------------------------------------------------------------------------
# Writing
# ------------------------------------------------------------------------------

if has latexmk; then
  alias lmk='latexmk -pdf -pvc *.tex'
fi

# ------------------------------------------------------------------------------
# Various
# ------------------------------------------------------------------------------

if is darwin; then
  alias flushdns='sudo discoveryutil udnsflushcaches'
fi

alias cleanup=$(inline '
  find . \( -name *.swo -o -name *.swp -o -name .DS_Store \) -print0 |
  xargs -0 rm')
