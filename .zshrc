PS1="%1~ %# "

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8
# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

set incsearch

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
alias ls="gls --color=auto"
alias la="ls -la"

# 入力補完
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
