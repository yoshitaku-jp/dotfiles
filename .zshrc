export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  vscode
  mise
)

source "$HOME/.rye/env"
source $ZSH/oh-my-zsh.sh

# cdコマンド実行後、lsを実行する
function cd() {
   builtin cd $@ && ls;
}

function pecofind() { # find コマンドの出力結果をpeco する
  if [ $# -eq 0 ]; then
    find . | peco
  else
    find $1 | peco
  fi
}
function pecofindd() { # find コマンドの出力結果をpeco する。 ファイルが選ばれたら1つ手前のディレクトリを返す
  if [ $# -eq 0 ]; then
    finded=`find . | peco`
  else
    finded=`find $1 | peco`
  fi
  if [ -f $finded ]; then
    echo $finded | perl -pe 's/\/[^\/]*$/\n/g'
  else
    echo $finded
  fi
}

# 環境変数
export LANG=ja_JP.UTF-8

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 同時に起動したzshの間でヒストリを共有
setopt share_history



# ディレクトリスタック
DIRSTACKSIZE=100
setopt AUTO_PUSHD


# ------------------------------
# GitHub Settings
# ------------------------------

# コマンドの履歴を表示し選択
function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# リポジトリを選択して移動
function peco-src () {
    local repo=$(ghq list | peco --query "$LBUFFER" --initial-filter=Fuzzy)
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# PRを選択してチェックアウト
function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-checkout-pull-request
bindkey "^g^p" peco-checkout-pull-request

# PRを選択してブラウザで表示
function peco-view-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr view --web ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-view-pull-request
bindkey "^g^v" peco-view-pull-request
