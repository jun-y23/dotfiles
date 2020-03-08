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

# cdの後にlsを実行
chpwd() { ls -ltr --color=auto }

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
# linuxのlsを実行
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$PATH:/Users/jumac/.nodebrew/current/bin

# 入力補完
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
