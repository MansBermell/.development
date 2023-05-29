function has {
  if type "${1}" > /dev/null; then
    return 0
  else
    return 1
  fi
}

function is {
  if [[ "$(echo $(uname) | tr '[:upper:]' '[:lower:]')" == "${1}" ]]; then
    return 0
  else
    return 1
  fi
}

# ------------------------------------------------------------------------------
# Terminal
# ------------------------------------------------------------------------------

TERM=xterm-256color

setopt prompt_subst
PROMPT='%{%F{green}%}%n%{%F{yellow}%}@%{%F{cyan}%}%m %{%F{blue}%}%c%{%F{green}%}$(git_prompt) %{%F{blue}%}$%{%F{none}%} '

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

setopt appendhistory
setopt incappendhistory
setopt sharehistory

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
if is darwin; then
  bindkey '\e[A' up-line-or-beginning-search
  bindkey '\e[B' down-line-or-beginning-search
else
  bindkey '^[OA' up-line-or-beginning-search
  bindkey '^[OB' down-line-or-beginning-search
fi

bindkey '[C' forward-word
bindkey '[D' backward-word
bindkey '^[a' beginning-of-line
bindkey '^[e' end-of-line

zstyle :completion::complete:-command-:: tag-order local-directories -

autoload -U compinit
compinit

if has tmux; then
  alias x='tmux attach || tmux new'
fi

# ------------------------------------------------------------------------------
# Editor
# ------------------------------------------------------------------------------

export EDITOR=vim
export VISUAL=vim

if is darwin && has mvim; then
  alias v=mvim
else
  alias v=vim
fi

# ------------------------------------------------------------------------------
# Versioning
# ------------------------------------------------------------------------------

function git_prompt {
  if has git; then
    branch=$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)
    if [ ! -z "${branch}" ]; then
      echo " [${branch}]"
    fi
  fi
}

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
  alias gl='git log'
  alias gp='git push'
  alias gpl='git pull'
  alias gs='git status'
fi

if has git && has grepdiff; then
  function gape {
    git diff -U0 $2 \
      | grepdiff -E $1 --output-matching=hunk \
      | git apply --cached --unidiff-zero
  }
fi

# ------------------------------------------------------------------------------
# Programming
# ------------------------------------------------------------------------------

if has cargo; then
  alias c=cargo
  alias cob='cargo bench --all-features'
  alias cod='cargo doc --all-features --open'
  alias cof='cargo fmt'
  alias col='cargo clippy --all-features'
  alias cot='cargo test --all-features --jobs 1'
fi

if has docker; then
  alias d=docker
  function run {
    docker run \
      --rm \
      --user "$(id -u):$(id -g)" \
      --volume "${PWD}:/workspace" \
      --workdir /workspace \
      "$@"
  }
fi

if has make; then
  alias m=make
fi

if has terraform; then
  alias t=terraform
fi

# ------------------------------------------------------------------------------
# Other
# ------------------------------------------------------------------------------

if has brew; then
  alias bu='brew update && brew upgrade && brew cleanup'
fi

if has open; then
  alias o=open
  alias .='open .'
fi

if is linux; then
  export LS_COLORS='di=35:ln=36:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:'
  alias ls='ls --color=auto'
fi

if is darwin; then
  export CLICOLOR=1
  export LSCOLORS=fxgxcxdxbxegedabagacad
  alias ls='ls -G'
fi

if has ag; then
  alias agc='ag -A1 -B1'
fi

alias grep='grep --color=auto'
