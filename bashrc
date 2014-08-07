# Terminal
[[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color

export CLICOLOR=1
export LSCOLORS=fxgxcxdxbxegedabagacad

alias grep='grep --color=auto'

export HISTSIZE=''
alias hstats='history | awk '\''{a[$2]++}END{for(i in a){print a[i] " " i}}'\'' | sort -rn | head -20'

export PS1='\[\033[0;32m\]\u\[\033[0;33m\]@\[\033[01;36m\]\h \[\033[01;34m\]\W \$\[\033[00m\] '

stty -ixon

# Editor
export EDITOR=vim
alias v=vim

# Git
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

# Programming
alias r=rails
alias rn='rails new --skip-active-record --skip-sprockets --skip-spring --skip-javascript --skip-test-unit --skip-bundle'

alias b=bundle
alias be='bundle exec'
alias beg='bundle exec guard'
alias bo='bundle open'

alias s=rspec

# Shortcuts
alias cleanup='find . \( -name "*.swp" -o -name ".DS_Store" \) | xargs rm'
