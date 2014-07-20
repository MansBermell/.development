# Terminal
export HISTSIZE=''
alias hstats='history | awk '\''{a[$2]++}END{for(i in a){print a[i] " " i}}'\'' | sort -rn | head -20'

export CLICOLOR=1
export LSCOLORS=fxgxcxdxbxegedabagacad

export PS1='\[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h \[\033[01;34m\]\W \$\[\033[00m\] '

#
# Editor
#
export EDITOR='vim'
alias v=mvim

#
# Git
#
alias g=git
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gs='git status'
alias gd='git diff'
alias gg='git grep'
alias gl='git log'
alias glo='git lo'
alias glf='git ls'
alias glg='git lg'

#
# Programming
#
alias r=rails
alias rn='rails new --skip-active-record --skip-sprockets --skip-spring --skip-javascript --skip-test-unit --skip-bundle'

alias be='bundle exec'
alias bo='EDITOR=mvim bundle open'

alias s=rspec

#
# Shortcuts
#
alias grep='grep --color'
alias cleanup='find . \( -name "*.swp" -o -name ".DS_Store" \) | xargs rm'
