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
  export LS_COLORS='di=35;40:ln=36;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
  alias ls='ls --color=auto'
else
  export CLICOLOR=1
  export LSCOLORS=fxgxcxdxbxegedabagacad
  alias ls='ls -G'
fi

alias grep='grep --color=auto'

export PS1=$(inline\
  '\[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h'\
  '\[\033[01;34m\]\W \$\[\033[00m\] ')

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
# Source code management
# ------------------------------------------------------------------------------

if has git; then
  alias g=git
  alias ga='git add'
  alias gap='git add --patch'
  alias gb='git branch'
  alias gc='git commit'
  alias gco='git checkout'
  alias gd='git diff'
  alias gds='git diff --staged'
  alias gg='git grep'
  alias gl='git log'
  alias glf='git lf'
  alias glg='git lg'
  alias glo='git lo'
  alias gp='git push'
  alias gpl='git pull'
  alias gs='git status'
fi

# ------------------------------------------------------------------------------
# Programming
# ------------------------------------------------------------------------------

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
# Various
# ------------------------------------------------------------------------------

alias cleanup=$(inline '
  find . \( -name "*.swp" -o -name ".DS_Store" \) |
  xargs rm')
