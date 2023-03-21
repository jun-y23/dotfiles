zstyle ":completion:*:commands" rehash 1
export LANG=ja_JP.UTF-8

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
alias python="python3"

PROMPT='
[%B%F{red}%n@%f%b:%F{green}%~%f]%F{cyan}$(git_super_status)%f
%F{yellow}$%f '


export PATH=$PATH:/Users/junyamaguchi/go/1.20.0/bin/

eval "$(gh completion -s zsh)"

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh

    autoload -Uz compinit
    compinit
fi

