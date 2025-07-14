export LANG=ja_JP.UTF-8


eval "$(/Users/junyamaguchi/.local/bin/mise activate zsh)"
eval "$(~/.local/bin/mise activate zsh)"

# 色を使用
autoload -Uz colors
colors

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ヒストリーに重複を表示しない
setopt histignorealldups
# ヒストリの共有の有効化
setopt share_history
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# ヒストリに追加されるコマンドが古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

alias v='nvim'
alias vi='nvim'

alias ga='git add .'
alias gco='git commit -m'
alias gs='git status'
alias gc='git checkout'
alias gb='git branch'


if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit

    autoload -U promptinit;
    promptinit

    prompt typewritten
fi

eval "$(gh completion -s zsh)"

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# peco + history
function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco --prompt "❯"`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection
