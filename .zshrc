PS1="%1~ %# "
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8
# 色を使用
autoload -Uz colors

# 補完
autoload -Uz compinit
# 入力補完
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}
alias la="ls -la"
alias mvim='/Applications/MacVim.app/Contents/bin/mvim "$@"'
alias cm='open -a Google\ Chrome'
alias ..='cd ..'
# github
alias gcb="git checkout -b"
alias gc="git checkout"
alias gco="git commit -m"
alias gs="git status"
alias gp="git push"
alias gb="git branch"
alias ga="git add"
alias gpush-u='git symbolic-ref --short HEAD | tr -d "\n" | xargs -I@ git push -u origin @'

alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

function ghq-new() {
    local REPONAME=$1

    if [ -z "$REPONAME" ]; then
        echo 'Repository name must be specified.'
        return
    fi

    local TMPDIR=/tmp/ghq_new
    local TMPREPODIR=$TMPDIR/$REPONAME

    mkdir -p $TMPREPODIR
    cd $TMPREPODIR

    local GITPATH="https://github.com/jun-y23"
    local REPOPATH=$GITPATH/$REPONAME


    git init
    gh repo create
    wait

    echo "# $REPONAME" > README.md
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git push -u origin main
    wait

    ghq get $REPOPATH

    cd $(ghq root)/$REPNAME

    rm -rf $TMPREPODIR
}

function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir="$(cdr -l | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^[' peco-cdr

function peco-ghq-look () {
    local ghq_roots="$(git config --path --get-all ghq.root)"
    local selected_dir=$(ghq list --full-path | \
        xargs -I{} ls -dl --time-style=+%s {}/.git | sort -nr | \
        sed "s,.*\(${ghq_roots/$'\n'/\|}\)/,," | \
        sed 's/\/.git//' | \
        peco --prompt="cd-ghq >" --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd $(ghq list --full-path | grep --color=never -E "/$selected_dir$")"
        zle accept-line
    fi
}

zle -N peco-ghq-look
bindkey '^G' peco-ghq-look


export PATH=$PATH:~/go/1.16.6/bin
