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

stty -ixon

if is linux; then
  export LS_COLORS=$(echo '
    di=35;40: ln=36;40: so=32;40: pi=33;40: ex=31;40: bd=34;46:
    cd=34;43: su= 0;41: sg= 0;46: tw= 0;42: ow=0;43:' | tr -d '\n ')
  alias ls='ls --color=auto'
else
  export CLICOLOR=1
  export LSCOLORS=fxgxcxdxbxegedabagacad
  alias ls='ls -G'
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

# ------------------------------------------------------------------------------
# Editor
# ------------------------------------------------------------------------------

export EDITOR=vim
alias v=vim

if is darwin && has gvim; then
  alias v=gvim
fi

# ------------------------------------------------------------------------------
# Programming
# ------------------------------------------------------------------------------

if has rbenv; then eval "$(rbenv init -)"; fi

if has rails; then
  alias r=rails
  alias rn=$(inline '
    rails new
      --skip-active-record
      --skip-sprockets
      --skip-spring
      --skip-javascript
      --skip-test-unit
      --skip-bundle')
fi

if has bundle; then
  alias b=bundle
  alias be='bundle exec'
  alias beg='bundle exec guard'
  alias bo='bundle open'
fi

if has rspec; then
  alias s=rspec
fi

# ------------------------------------------------------------------------------
# Source code management
# ------------------------------------------------------------------------------

if has git; then
  for command in '' a ap b c co d ds g l lf lg lo p pl s; do
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
# Various
# ------------------------------------------------------------------------------

alias cleanup=$(inline '
  find . \( -name "*.swp" -o -name ".DS_Store" \) -print0 |
  xargs -0 rm')
